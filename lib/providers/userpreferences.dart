import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserPreferences with ChangeNotifier {
  User _user;
  final String authToken;
  final String userId;

  UserPreferences(this.authToken, this.userId, this._user);

  User get user {
    return _user;
  }

  Future<void> fetchUserData() async {
    var url =
        'https://mpibrasil.firebaseio.com/users/$userId.json?auth=$authToken';

    try {
      print('loading user preferences...');
      final response = await http.get(url);
      final responseData = json.decode(response.body) as Map<String, dynamic>;

      if (responseData == null) {
        print('failed to load user preferences');
        return;
      }

      print('done loading user preferences.');
      // include userId before importing userPreferences
      responseData['id'] = userId;
      // import other preferences from the db json reply
      _user = User.fromJson(responseData);
    } catch (error) {
      throw (error);
    }
    notifyListeners();
  }

  bool isFavorite(String medId) {
    return _user.favorites.containsKey(medId);
  }

  Future<void> toggleFavorite(String medId) async {
    final url =
        'https://mpibrasil.firebaseio.com/users/$userId/favorites/$medId.json?auth=$authToken';

    var currentStatus = isFavorite(medId);
    var newStatus = !currentStatus;

    if (newStatus) {
      try {
        // debug
        print('add favorite: [$medId]');
        final response = await http.put(
          url,
          body: json.encode(newStatus),
        );
        final responseData = json.decode(response.body);
      } catch (error) {
        throw (error);
      }
    } else {
      try {
        final response = await http.delete(url);
        final responseData = json.decode(response.body);
        // debug
        print('del favorite: $medId');
      } catch (error) {
        throw (error);
      }
    }
    fetchUserData();
  }
}
