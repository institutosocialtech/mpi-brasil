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

  //
  // fetch user preferences from the Firebase API
  //

  Future<void> fetchUserData() async {
    var url =
        'https://mpibrasil.firebaseio.com/users/$userId.json?auth=$authToken';

    try {
      // make the api call to load user preferences
      print('loading user preferences...');
      final response = await http.get(url);
      var responseData = json.decode(response.body) as Map<String, dynamic>;

      // initialize user preferences in case they don't exist
      // example: old users that haven't filled the sign up form yet
      // won't need to do it once the sign up screen is done
      // todo: handle this during user sign up
      if (responseData == null) {
        print('new user detected, initializing preferences.');
        responseData = new Map<String, dynamic>();
      }

      // include userId in the json reply
      // then finish loading preferences
      responseData['id'] = userId;
      _user = User.fromJson(responseData);
    } catch (error) {
      throw (error);
    }
    // tell listeners to update
    notifyListeners();
  }

  //
  // check favorite status
  //
  bool isFavorite(String medId) {
    // returns true if the key is present in the favorites Map
    return _user.favorites.containsKey(medId);
  }

  //
  // change the favorite status
  //
  Future<void> toggleFavorite(String medId) async {
    final url =
        'https://mpibrasil.firebaseio.com/users/$userId/favorites/$medId.json?auth=$authToken';

    // read current status and reverse it's value
    var currentStatus = isFavorite(medId);
    var newStatus = !currentStatus;

    if (newStatus) {
      // add favorite
      try {
        // write local variable and tell the ui to update
        _user.favorites.addAll({medId: true});
        notifyListeners();

        // send the api call
        final response = await http.put(url, body: json.encode(newStatus));
        final responseData = json.decode(response.body);

        // todo: handle api errors
      } catch (error) {
        throw (error);
      }
    } else {
      // remove favorite
      try {
        // write local variable and tell the ui to update
        _user.favorites.remove(medId);
        notifyListeners();

        // send api call to delete favorite
        final response = await http.delete(url);
        final responseData = json.decode(response.body);

        // todo: handle api errors
      } catch (error) {
        throw (error);
      }
    }
  }
}
