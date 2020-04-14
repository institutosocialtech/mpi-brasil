import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'keyword.g.dart';

@JsonSerializable(explicitToJson: true)
class Keyword with ChangeNotifier {
  final String id;
  final String word;
  final List<String> synonyms; 
  final String definition;
  final String source;

  Keyword(
    this.id,
    this.word,
    this.synonyms,
    this.definition,
    this.source
  );

  factory Keyword.fromJson(Map<String, dynamic> json) => _$KeywordFromJson(json);

  Map<String, dynamic> toJson() => _$KeywordToJson(this);

  String printJson() {
    var jmap = _$KeywordToJson(this);
    return jsonEncode(jmap);
  }

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