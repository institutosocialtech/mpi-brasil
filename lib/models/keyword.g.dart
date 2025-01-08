// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyword.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Keyword _$KeywordFromJson(Map<String, dynamic> json) => Keyword(
      id: json['id'] as String,
      word: json['word'] as String,
      definition: json['definition'] as String,
      source: json['source'] as String,
      synonyms: (json['synonyms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$KeywordToJson(Keyword instance) => <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'synonyms': instance.synonyms,
      'definition': instance.definition,
      'source': instance.source,
    };
