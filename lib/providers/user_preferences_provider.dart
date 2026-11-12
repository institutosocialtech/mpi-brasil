import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mpibrasil/models/user.dart';
import 'package:mpibrasil/providers/auth_provider.dart';
import 'package:mpibrasil/providers/auth_state.dart';

part 'user_preferences_provider.g.dart';

@Riverpod(keepAlive: true)
class UserPreferencesNotifier extends _$UserPreferencesNotifier {
  static const _baseUrl = 'https://api-staging.mpibrasil.dev';

  @override
  User build() {
    return User.empty();
  }

  String? get _authToken {
    final authState = ref.read(authNotifierProvider).valueOrNull;

    if (authState is Authenticated) {
      return authState.token;
    }

    return null;
  }

  String? get _userId {
    final authState = ref.read(authNotifierProvider).valueOrNull;

    if (authState is Authenticated) {
      return authState.userId;
    }

    return null;
  }

  Map<String, String> get _headers {
    return {
      'Authorization': 'Bearer $_authToken',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  void _checkResponse(http.Response response, String operation) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Erro ao $operation: '
        '${response.statusCode} - ${response.body}',
      );
    }
  }

  Future<void> fetchUserData() async {
    final token = _authToken;
    final userId = _userId;

    if (token == null || userId == null) return;

    final uri = Uri.parse('$_baseUrl/users/$userId.json');

    final response = await http.get(uri, headers: _headers);

    _checkResponse(response, 'buscar dados do usuário');

    final Map<String, dynamic> responseData = response.body.trim() == 'null'
        ? {}
        : json.decode(response.body) as Map<String, dynamic>;

    responseData['id'] = userId;

    state = User.fromJson(responseData);
  }

  Future<void> updateUserData({
    String? name,
    String? occupation,
    DateTime? birthDate,
  }) async {
    final token = _authToken;
    final userId = _userId;

    if (token == null || userId == null) return;

    final previousState = state;

    final uri = Uri.parse('$_baseUrl/users/$userId.json');

    final requestData = {
      if (name != null) 'name': name,
      if (occupation != null) 'occupation': occupation,
      if (birthDate != null)
        'birth_date':
            '${birthDate.year.toString().padLeft(4, '0')}-'
            '${birthDate.month.toString().padLeft(2, '0')}-'
            '${birthDate.day.toString().padLeft(2, '0')}',
    };

    state = state.copyWith(
      name: name ?? state.name,
      occupation: occupation ?? state.occupation,
      birthDate: birthDate ?? state.birthDate,
    );

    try {
      final response = await http.patch(
        uri,
        headers: _headers,
        body: json.encode(requestData),
      );

      _checkResponse(response, 'atualizar dados do usuário');
    } catch (_) {
      state = previousState;
      rethrow;
    }
  }

  bool isFavorite(String medId) {
    return state.favorites?.containsKey(medId) ?? false;
  }

  Future<void> toggleFavorite(String medId) async {
    final token = _authToken;
    final userId = _userId;

    if (token == null || userId == null) return;

    if (int.tryParse(medId) == null) {
      throw ArgumentError('O ID do medicamento deve ser numérico.');
    }

    final previousState = state;
    final currentStatus = isFavorite(medId);
    final newStatus = !currentStatus;

    final uri = Uri.parse('$_baseUrl/users/$userId/favorites/$medId.json');

    final newFavorites = Map<String, bool>.from(state.favorites ?? {});

    if (newStatus) {
      newFavorites[medId] = true;
    } else {
      newFavorites.remove(medId);
    }

    state = state.copyWith(favorites: newFavorites);

    try {
      final response = newStatus
          ? await http.put(uri, headers: _headers, body: json.encode(true))
          : await http.delete(uri, headers: _headers);

      _checkResponse(
        response,
        newStatus ? 'adicionar favorito' : 'remover favorito',
      );
    } catch (_) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> sendReport(String medName, String errorType) async {
    final token = _authToken;
    final userId = _userId;

    if (token == null || userId == null) return;

    final url = 'https://mpibrasil.firebaseio.com/app_reports.json?auth=$token';

    final uri = Uri.parse(url);

    await http.post(
      uri,
      body: json.encode({
        'user': userId,
        'med': medName,
        'error_type': errorType,
        'date': DateTime.now().toString(),
      }),
    );
  }

  void reset() {
    state = User.empty();
  }
}
