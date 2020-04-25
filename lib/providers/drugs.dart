import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/drug.dart';

class Drugs with ChangeNotifier {

  List<Drug> _drugs = [];

  List<Drug> get drugs {
    if (_drugs.length == 0) {
      fetchMedsFromDB();
    }
    return [..._drugs];
  }

  void fetchMedsFromDB() async {
    const url = 'https://mpibrasil.firebaseio.com/v2_0_0/pt/meds.json';

    print("loading drug db...");
    final response = await http.get(url, headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
        print("drug db loaded, filling list!");
        Map<String,dynamic> map = json.decode(response.body);
        map.forEach((key, value) => _drugs.add(Drug.fromJson(value)));
    } else {
      print("error loading drugs: " + response.statusCode.toString());
    }
    print("done loading drugs.");
    notifyListeners();
  }
  
}
