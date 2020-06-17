import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true)
class User with ChangeNotifier {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'occupation')
  String occupation;
  @JsonKey(name: 'birth_date')
  DateTime birthDate;
  @JsonKey(name: 'favorites', defaultValue: {})
  Map<String, bool> favorites;

  User({
    this.id,
    this.name,
    this.occupation,
    this.birthDate,
    this.favorites,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

}
