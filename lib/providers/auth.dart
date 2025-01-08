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
  final _authBaseUrl = 'https://identitytoolkit.googleapis.com/v1';
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
    final url = '$_authBaseUrl/accounts:$urlSegment?key=$_apiKey';

    try {
      final requestBody = json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      });

      final response = await http.post(Uri.parse(url), body: requestBody);
      final responseData = json.decode(response.body);

      // raise response errors up the stack
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      // store tokens
      await _storeLocalData(
        idToken: responseData['idToken'],
        refreshToken: responseData['refreshToken'],
        userId: responseData['localId'],
        expDuration: responseData['expiresIn'],
      );

      _autoLogout();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<bool> _refreshAuth() async {
    final url = 'https://securetoken.googleapis.com/v1/token?key=$_apiKey';

    try {
      final requestBody = json.encode({
        'grant_type': 'refresh_token',
        'refresh_token': _refreshToken,
      });

      final response = await http.post(Uri.parse(url), body: requestBody);
      final responseData = json.decode(response.body);

      // invalidate token refresh if response contains an error
      if (responseData['error'] != null) return false;

      // store new tokens
      await _storeLocalData(
        idToken: responseData['id_token'],
        refreshToken: responseData['refresh_token'],
        userId: responseData['user_id'],
        expDuration: responseData['expires_in'],
      );
    } catch (error) {
      return false;
    }

    return true;
  }

  Future<void> _fetchLocalData() async {
    final data = await _secureStorage.read(key: 'userData');
    if (data == null) return;

    final localData = json.decode(data) as Map<String, dynamic>;

    _userId = localData['userId'];
    _token = localData['token'];
    _refreshToken = localData['refreshToken'];
    _expirationDate = DateTime.parse(localData['expirationDate']);
  }

  Future<void> _storeLocalData({
    required String idToken,
    required String refreshToken,
    required String userId,
    required String expDuration,
  }) async {
    final tokenDuration = Duration(seconds: int.parse(expDuration));

    // store memory vars
    _token = idToken;
    _refreshToken = refreshToken;
    _userId = userId;
    _expirationDate = DateTime.now().add(tokenDuration);

    // prep local storage json key
    final data = json.encode({
      'token': token,
      'refreshToken': refreshToken,
      'userId': userId,
      'expirationDate': DateTime.now().add(tokenDuration).toIso8601String(),
    });

    // save json to secure storage
    await _secureStorage.write(key: 'userData', value: data);
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    // read and validate secure storage
    await _fetchLocalData();
    if (_token == null || _refreshToken == null) return false;

    // check if token is still valid
    if (_expirationDate!.isBefore(DateTime.now())) {
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

    await _secureStorage.delete(key: 'userData');
  }

  void _autoLogout() {
    if (_authTimer != null) _authTimer!.cancel();

    final timeToExpiry = _expirationDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<void> forgotPassword(String email) async {
    final url = '$_authBaseUrl/accounts:sendOobCode?key=$_apiKey';

    try {
      final requestBody = json.encode({
        'requestType': "PASSWORD_RESET",
        'email': email,
      });

      final response = await http.post(Uri.parse(url), body: requestBody);
      final responseData = json.decode(response.body);

      // raise errors up the stack
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> deleteAccount() async {
    final url = '$_authBaseUrl/accounts:delete?key=$_apiKey';

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
