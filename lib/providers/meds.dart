import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:diacritic/diacritic.dart';
import 'package:http/http.dart' as http;
import '../models/med.dart';

class Meds with ChangeNotifier {
  List<Med> _meds = [];
  final String authToken;
  final String userId;

  Meds(this.authToken, this.userId, this._meds);

  List<Med> get meds {
    return [..._meds];
  }

  Med findById(String medId) {
    return _meds.firstWhere((element) => element.id == medId);
  }

  Future<void> fetchMedsFromDB({force: false}) async {
    var url =
        'https://mpibrasil.firebaseio.com/v2_0_0/pt/meds.json?auth=$authToken';

    if (!(force || _meds.length == 0)) {
      return;
    }

    try {
      print("loading med db...");
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;

      if (data == null) {
        print("error loading meds: " + response.statusCode.toString());
        return;
      }

      // debug
      print('loading favorite data');
      var favUrl =
          'https://mpibrasil.firebaseio.com/users/$userId/favorites.json?auth=$authToken';
      final favResponse = await http.get(favUrl);
      final favData = json.decode(favResponse.body);

      List<Med> loadedMeds = [];
      data.forEach((firebaseId, value) {
        // insert firebase id
        value['id'] = firebaseId;
        value['isFavorite'] =
            favData == null ? false : favData[firebaseId] ?? false;
        loadedMeds.add(Med.fromJson(value));
      });

      loadedMeds.sort((a, b) => removeDiacritics(a.name)
          .toUpperCase()
          .compareTo(removeDiacritics(b.name).toUpperCase()));
      _meds = loadedMeds;

      print("done loading meds.");
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  bool isFavorite(String medId) {
    return findById(medId).isFavorite;
  }

  Future<void> toggleFavorite(String medId) async {
    var med = findById(medId);
    med.isFavorite = !med.isFavorite;
    notifyListeners();

    final url =
        'https://mpibrasil.firebaseio.com/users/$userId/favorites/$medId.json?auth=$authToken';

    if (med.isFavorite) {
      try {
        // debug
        print('add favorite: ${med.name}');
        final response = await http.put(
          url,
          body: json.encode(med.isFavorite),
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
        print('del favorite: ${med.name}');
      } catch (error) {
        throw (error);
      }
    }
  }
}
