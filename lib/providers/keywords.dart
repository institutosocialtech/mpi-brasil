import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:diacritic/diacritic.dart';
import 'package:http/http.dart' as http;
import '../models/keyword.dart';

class Keywords with ChangeNotifier {
  List<Keyword> _keywords = [];
  String authToken;

  Keywords(this.authToken, this._keywords);

  List<Keyword> get keywords {
    return [..._keywords];
  }

  Future<void> fetchKeywordsFromDB({force: false}) async {
    var url =
        'https://mpibrasil.firebaseio.com/v2_0_0/pt/keywords.json?auth=$authToken';

    if (!(force || _keywords.length == 0)) {
      return;
    }

    try {
      print("loading keyword db...");
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;

      if (data == null) {
        print("error loading keywords: " + response.statusCode.toString());
        return;
      }

      print("keyword db loaded, filling list!");
      final List<Keyword> loadedKeywords = [];
      data.forEach((firebaseId, value) {
        // insert firebaseId
        value['id'] = firebaseId;
        loadedKeywords.add(Keyword.fromJson(value));
      });

      loadedKeywords.sort((a, b) => removeDiacritics(a.word)
          .toUpperCase()
          .compareTo(removeDiacritics(b.word).toUpperCase()));
      _keywords = loadedKeywords;

      print("done loading keywords.");
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
