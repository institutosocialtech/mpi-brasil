import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mpibrasil/models/http_exception.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _refreshToken;
  DateTime? _expirationDate;
  String? _userId;
  Timer? _authTimer;

  final _secureStorage = FlutterSecureStorage();
  final _apiKey = 'AIzaSyC-5nNIwn2nrGNCiMM2yFbj-lDqqmqR-YA';

  bool get isAuth => token != null;

  String? get userId => _userId;

  String? get token {
    if (_expirationDate != null &&
        _expirationDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }

    return null;
  }

  Future<void> _authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=$_apiKey';

    try {
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );

      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _token = responseData['idToken'];
      _refreshToken = responseData['refreshToken'];
      _userId = responseData['localId'];
      _expirationDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));

      _autoLogout();
      notifyListeners();

      final userData = json.encode(
        {
          'token': _token,
          'refreshToken': _refreshToken,
          'userId': _userId,
          'expirationDate': _expirationDate!.toIso8601String(),
        },
      );

      await _secureStorage.write(key: 'userData', value: userData);
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> _refreshAuth() async {
    final url = 'https://securetoken.googleapis.com/v1/token?key=$_apiKey';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'grant_type': 'refresh_token',
          'refresh_token': _refreshToken,
        }),
      );

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) return false;

      _token = responseData['id_token'];
      _refreshToken = responseData['refresh_token'];
      _userId = responseData['user_id'];
      _expirationDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expires_in'])));

      await _secureStorage.write(
        key: 'userData',
        value: json.encode({
          'token': _token,
          'refreshToken': _refreshToken,
          'userId': _userId,
          'expirationDate': _expirationDate!.toIso8601String(),
        }),
      );
    } catch (error) {
      return false;
    }

    return true;
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    // read and validate secure storage
    final userDataString = await _secureStorage.read(key: 'userData');
    if (userDataString == null) return false;

    // parse secure storage keys
    final userData = json.decode(userDataString) as Map<String, dynamic>;

    // set user data
    _token = userData['token'];
    _refreshToken = userData['refreshToken'];
    _userId = userData['userId'];
    _expirationDate = DateTime.parse(userData['expirationDate']);

    // check if token is still valid
    if (_expirationDate!.isAfter(DateTime.now())) {
      bool isRefreshed = await _refreshAuth();

      if (!isRefreshed) {
        await logout();
        return false;
      }
    }

    // reset logout timers and tell providers we're logged in
    _autoLogout();
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _refreshToken = null;
    _expirationDate = null;
    _authTimer?.cancel();
    notifyListeners();

    await _secureStorage.deleteAll();
  }

  void _autoLogout() {
    if (_authTimer != null) _authTimer!.cancel();

    final timeToExpiry = _expirationDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<void> forgotPassword(String email) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$_apiKey';

    try {
      final uri = Uri.parse(url);
      final response = await http.post(uri,
          body: json.encode({'requestType': "PASSWORD_RESET", 'email': email}));

      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> deleteAccount() async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:delete?key=$_apiKey';

    try {
      final uri = Uri.parse(url);
      final response =
          await http.post(uri, body: json.encode({"idToken": _token}));

      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
