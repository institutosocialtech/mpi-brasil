import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:mpibrasil/models/http_exception.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expirationDate;
  String? _userId;
  Timer? _authTimer;

  final _secureStorage = FlutterSecureStorage();

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
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyC-5nNIwn2nrGNCiMM2yFbj-lDqqmqR-YA';

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
      _userId = responseData['localId'];
      _expirationDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      _autoLogout();
      notifyListeners();

      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expirationDate': _expirationDate!.toIso8601String(),
        },
      );

      await _secureStorage.write(key: 'userData', value: userData);
    } catch (error) {
      throw (error);
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final userDataString = await _secureStorage.read(key: 'userData');

    // no user data stored
    if (userDataString == null) return false;

    // parse prefs string into map
    final userData = json.decode(userDataString) as Map<String, dynamic>;

    // validate token expiration date
    final expirationDate = DateTime.parse(userData['expirationDate']);
    if (expirationDate.isBefore(DateTime.now())) return false;

    // set user data
    _token = userData['token'];
    _userId = userData['userId'];
    _expirationDate = expirationDate;
    _autoLogout();

    // tell providers we're logged in
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expirationDate = null;
    _authTimer!.cancel();
    notifyListeners();

    await _secureStorage.deleteAll();
  }

  void _autoLogout() {
    if (_authTimer != null) _authTimer!.cancel();

    final timeToExpiry = _expirationDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<void> forgotPassword(String email) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=AIzaSyC-5nNIwn2nrGNCiMM2yFbj-lDqqmqR-YA';

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
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:delete?key=AIzaSyC-5nNIwn2nrGNCiMM2yFbj-lDqqmqR-YA';

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
