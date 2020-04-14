// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Keyword _$KeywordFromJson(Map<String, dynamic> json) {
  return Keyword(
    json['id'] as String,
    json['word'] as String,
    (json['synonyms'] as List)?.map((e) => e as String)?.toList(),
    json['definition'] as String,
    json['source'] as String,
  );
}

Map<String, dynamic> _$KeywordToJson(Keyword instance) => <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'synonyms': instance.synonyms,
      'definition': instance.definition,
      'source': instance.source,
    };
