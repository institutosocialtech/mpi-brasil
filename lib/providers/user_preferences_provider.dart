import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:mpibrasil/models/user.dart';
import 'package:mpibrasil/providers/auth_provider.dart';
import 'package:mpibrasil/providers/auth_state.dart';

part 'user_preferences_provider.g.dart';

@Riverpod(keepAlive: true)
class UserPreferencesNotifier extends _$UserPreferencesNotifier {
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

  Future<void> fetchUserData() async {
    final token = _authToken;
    final userId = _userId;
    if (token == null || userId == null) return;

    final url = 'https://mpibrasil.firebaseio.com/users/$userId.json?auth=$token';

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final Map<String, dynamic> responseData = response.body == 'null'
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

    final url = 'https://mpibrasil.firebaseio.com/users/$userId.json?auth=$token';

    // Update locally first
    state = state.copyWith(
      name: name ?? state.name,
      occupation: occupation ?? state.occupation,
      birthDate: birthDate ?? state.birthDate,
    );

    final uri = Uri.parse(url);
    await http.patch(
      uri,
      body: json.encode({
        if (name != null) 'name': name,
        if (occupation != null) 'occupation': occupation,
        if (birthDate != null) 'birth_date': birthDate.toString(),
      }),
    );
  }

  bool isFavorite(String medId) {
    return state.favorites?.containsKey(medId) ?? false;
  }

  Future<void> toggleFavorite(String medId) async {
    final token = _authToken;
    final userId = _userId;
    if (token == null || userId == null) return;

    final url =
        'https://mpibrasil.firebaseio.com/users/$userId/favorites/$medId.json?auth=$token';

    final currentStatus = isFavorite(medId);
    final newStatus = !currentStatus;

    // Update local state first
    final newFavorites = Map<String, bool>.from(state.favorites ?? {});
    if (newStatus) {
      newFavorites[medId] = true;
    } else {
      newFavorites.remove(medId);
    }
    state = state.copyWith(favorites: newFavorites);

    try {
      final uri = Uri.parse(url);
      if (newStatus) {
        await http.put(uri, body: json.encode(newStatus));
      } else {
        await http.delete(uri);
      }
    } catch (error) {
      // Revert on error
      final revertedFavorites = Map<String, bool>.from(state.favorites ?? {});
      if (currentStatus) {
        revertedFavorites[medId] = true;
      } else {
        revertedFavorites.remove(medId);
      }
      state = state.copyWith(favorites: revertedFavorites);
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
