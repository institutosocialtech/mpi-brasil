import 'package:flutter/foundation.dart';

class Keyword with ChangeNotifier {

  final String word;
  final List<String> synonyms; 
  final String definition;
  final String source;

  Keyword(
    this.word,
    this.synonyms,
    this.definition,
    this.source
  );

  String synonymsListToString() {
    String output = "";

    for (String s in synonyms) {
      if (output == "")
        output = s;
      else
        output += ", " + s;
    }
    return output;
  }
}