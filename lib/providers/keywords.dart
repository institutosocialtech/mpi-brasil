import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/keyword.dart';

class Keywords with ChangeNotifier {

	List<Keyword> _keywords = [];

	List<Keyword> get keywords {
    if (_keywords.length == 0) {
      fetchKeywordsFromDB();
    }
    _keywords.sort((a,b) => a.word.toUpperCase().compareTo(b.word.toUpperCase()));
		return [..._keywords];
	}

  void fetchKeywordsFromDB() async {
    const url = 'https://mpibrasil.firebaseio.com/v2_0_0/pt/keywords.json';

    print("loading keyword db...");
    final response = await http.get(url, headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
        print("keyword db loaded, filling list!");
        Map<String,dynamic> map = json.decode(response.body);
        map.forEach((String dbID, dynamic values) => _keywords.add(Keyword.fromJson(values)));
    } else {
      print("error loading keywords: " + response.statusCode.toString());
    }
    print("done loading keywords.");
    notifyListeners();
  }

}