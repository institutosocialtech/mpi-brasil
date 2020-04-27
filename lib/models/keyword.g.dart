// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Keyword _$KeywordFromJson(Map<String, dynamic> json) {
  return Keyword(
    id: json['name'] as String,
    word: json['word'] as String,
    synonyms: (json['synonyms'] as List)?.map((e) => e as String)?.toList(),
    definition: json['definition'] as String,
    source: json['source'] as String,
  );
}

Map<String, dynamic> _$KeywordToJson(Keyword instance) => <String, dynamic>{
      'name': instance.id,
      'word': instance.word,
      'synonyms': instance.synonyms,
      'definition': instance.definition,
      'source': instance.source,
    };
