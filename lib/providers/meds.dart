import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:diacritic/diacritic.dart';
import 'package:http/http.dart' as http;
import '../models/med.dart';

class Meds with ChangeNotifier {
  List<Med> _meds = [];
  final String authToken;

  Meds(this.authToken, this._meds);

  List<Med> get meds {
    return [..._meds];
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

      print("med db loaded, filling list!");
      List<Med> loadedMeds = [];
      data.forEach((key, value) => loadedMeds.add(Med.fromJson(value)));

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
}
