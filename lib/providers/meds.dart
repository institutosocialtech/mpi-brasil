import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/med.dart';
import 'package:diacritic/diacritic.dart';

class Meds with ChangeNotifier {

  List<Med> _meds = [];

  List<Med> get meds {
    if (_meds.length == 0) {
      fetchMedsFromDB();
    }
    _meds.sort((a, b) => removeDiacritics(a.name).toUpperCase().compareTo(removeDiacritics(b.name).toUpperCase()) );
    return [..._meds];
  }

  void fetchMedsFromDB() async {
    const url = 'https://mpibrasil.firebaseio.com/v2_0_0/pt/meds.json';

    print("loading med db...");
    final response = await http.get(url, headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
        print("med db loaded, filling list!");
        Map<String,dynamic> map = json.decode(response.body);
        map.forEach((key, value) => _meds.add(Med.fromJson(value)));
    } else {
      print("error loading meds: " + response.statusCode.toString());
    }
    print("done loading meds.");
    notifyListeners();
  }
  
}
