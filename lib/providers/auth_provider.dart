import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mpibrasil/models/http_exception.dart';
import 'package:mpibrasil/providers/auth_state.dart';
import 'package:mpibrasil/providers/keywords_provider.dart';
import 'package:mpibrasil/providers/meds_provider.dart';
import 'package:mpibrasil/providers/user_preferences_provider.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  final _secureStorage = const FlutterSecureStorage();
  final _authBaseUrl = 'https://identitytoolkit.googleapis.com/v1';
  final _apiKey = 'AIzaSyC-5nNIwn2nrGNCiMM2yFbj-lDqqmqR-YA';

  Timer? _authTimer;

  @override
  Future<AuthState> build() async {
    ref.onDispose(() {
      _authTimer?.cancel();
    });

    // Try auto-login on initialization
    final result = await _tryAutoLogin();
    return result;
  }

  Future<AuthState> _tryAutoLogin() async {
    final data = await _secureStorage.read(key: 'userData');
    if (data == null) return const Unauthenticated();

    final localData = json.decode(data) as Map<String, dynamic>;
    final token = localData['token'] as String?;
    final refreshToken = localData['refreshToken'] as String?;
    final userId = localData['userId'] as String?;
    final expirationDateString = localData['expirationDate'] as String?;

    if (token == null || refreshToken == null || userId == null || expirationDateString == null) {
      return const Unauthenticated();
    }

    final expirationDate = DateTime.parse(expirationDateString);

    // Check if token is expired
    if (expirationDate.isBefore(DateTime.now())) {
      // Try to refresh
      final refreshResult = await _refreshAuth(refreshToken, userId);
      if (refreshResult == null) {
        await _secureStorage.delete(key: 'userData');
        return const Unauthenticated();
      }
      return refreshResult;
    }

    // Token is still valid
    _setAutoLogoutTimer(expirationDate);
    return Authenticated(
      token: token,
      userId: userId,
      refreshToken: refreshToken,
      expirationDate: expirationDate,
    );
  }

  Future<Authenticated?> _refreshAuth(String refreshToken, String userId) async {
    final url = 'https://securetoken.googleapis.com/v1/token?key=$_apiKey';

    try {
      final requestBody = json.encode({
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
      });

      final response = await http.post(Uri.parse(url), body: requestBody);
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) return null;

      final newToken = responseData['id_token'] as String;
      final newRefreshToken = responseData['refresh_token'] as String;
      final newUserId = responseData['user_id'] as String;
      final expiresIn = int.parse(responseData['expires_in'] as String);
      final newExpirationDate = DateTime.now().add(Duration(seconds: expiresIn));

      await _storeLocalData(
        idToken: newToken,
        refreshToken: newRefreshToken,
        userId: newUserId,
        expirationDate: newExpirationDate,
      );

      _setAutoLogoutTimer(newExpirationDate);

      return Authenticated(
        token: newToken,
        userId: newUserId,
        refreshToken: newRefreshToken,
        expirationDate: newExpirationDate,
      );
    } catch (error) {
      return null;
    }
  }

  Future<void> _storeLocalData({
    required String idToken,
    required String refreshToken,
    required String userId,
    required DateTime expirationDate,
  }) async {
    final data = json.encode({
      'token': idToken,
      'refreshToken': refreshToken,
      'userId': userId,
      'expirationDate': expirationDate.toIso8601String(),
    });

    await _secureStorage.write(key: 'userData', value: data);
  }

  void _setAutoLogoutTimer(DateTime expirationDate) {
    _authTimer?.cancel();
    final timeToExpiry = expirationDate.difference(DateTime.now()).inSeconds;
    if (timeToExpiry > 0) {
      _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
    }
  }

  Future<void> _authenticate(String email, String password, String urlSegment) async {
    final url = '$_authBaseUrl/accounts:$urlSegment?key=$_apiKey';

    final requestBody = json.encode({
      'email': email,
      'password': password,
      'returnSecureToken': true,
    });

    final response = await http.post(Uri.parse(url), body: requestBody);
    final responseData = json.decode(response.body);

    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    }

    final token = responseData['idToken'] as String;
    final refreshToken = responseData['refreshToken'] as String;
    final userId = responseData['localId'] as String;
    final expiresIn = int.parse(responseData['expiresIn'] as String);
    final expirationDate = DateTime.now().add(Duration(seconds: expiresIn));

    await _storeLocalData(
      idToken: token,
      refreshToken: refreshToken,
      userId: userId,
      expirationDate: expirationDate,
    );

    _setAutoLogoutTimer(expirationDate);

    state = AsyncData(Authenticated(
      token: token,
      userId: userId,
      refreshToken: refreshToken,
      expirationDate: expirationDate,
    ));
  }

  Future<void> login(String email, String password) async {
    await _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> signup(String email, String password) async {
    await _authenticate(email, password, 'signUp');
  }

  Future<void> logout() async {
    _authTimer?.cancel();
    await _secureStorage.delete(key: 'userData');
    ref.read(keywordsNotifierProvider.notifier).reset();
    ref.read(medsNotifierProvider.notifier).reset();
    ref.read(userPreferencesNotifierProvider.notifier).reset();
    state = const AsyncData(Unauthenticated());
  }

  Future<void> forgotPassword(String email) async {
    final url = '$_authBaseUrl/accounts:sendOobCode?key=$_apiKey';

    final requestBody = json.encode({
      'requestType': 'PASSWORD_RESET',
      'email': email,
    });

    final response = await http.post(Uri.parse(url), body: requestBody);
    final responseData = json.decode(response.body);

    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    }
  }

  Future<void> deleteAccount() async {
    final currentState = state.valueOrNull;
    if (currentState is! Authenticated) {
      throw HttpException('MISSING_ID_TOKEN');
    }

    final url = '$_authBaseUrl/accounts:delete?key=$_apiKey';

    final response = await http.post(
      Uri.parse(url),
      body: json.encode({'idToken': currentState.token}),
    );

    final responseData = json.decode(response.body);

    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    }
  }
}
