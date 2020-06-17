// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    name: json['name'] as String,
    occupation: json['occupation'] as String,
    birthDate: json['birth_date'] == null
        ? null
        : DateTime.parse(json['birth_date'] as String),
    favorites: (json['favorites'] as Map<String, dynamic>)?.map(
          (k, e) => MapEntry(k, e as bool),
        ) ??
        {},
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'occupation': instance.occupation,
      'birth_date': instance.birthDate?.toIso8601String(),
      'favorites': instance.favorites,
    };
