import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User with ChangeNotifier {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'name', defaultValue: '')
  String? name;
  @JsonKey(name: 'occupation', defaultValue: '')
  String? occupation;
  @JsonKey(name: 'birth_date', defaultValue: null)
  DateTime? birthDate;
  @JsonKey(name: 'favorites', defaultValue: {})
  Map<String, bool>? favorites;

  User({
    required this.id,
    this.name,
    this.occupation,
    this.birthDate,
    this.favorites,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
