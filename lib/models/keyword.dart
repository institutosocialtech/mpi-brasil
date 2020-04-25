import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mpibrasil/providers/keywords.dart';

part 'keyword.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class Keyword with ChangeNotifier {
  final String id;
  final String word;
  final List<String> synonyms;
  final String definition;
  final String source;

  Keyword({
    this.id,
    this.word,
    this.synonyms,
    this.definition,
    this.source,
  });

  factory Keyword.fromJson(Map<String, dynamic> json) {
    Keyword a = _$KeywordFromJson(json);

    if (a.synonyms.length == 1 && a.synonyms[0].length == 0) {
      List<String> emptyList = [];
      return Keyword(
        id: a.id,
        word: a.word,
        synonyms: emptyList,
        definition: a.definition,
        source: a.source,
      );
    }

    return a;
  }

  Map<String, dynamic> toJson() => _$KeywordToJson(this);

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
