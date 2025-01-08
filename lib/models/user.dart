import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mpibrasil/generated/l10n.dart';

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
  @JsonKey(name: 'beta_tester', defaultValue: false)
  bool? betaTester;

  User({
    required this.id,
    this.betaTester,
    this.name,
    this.occupation,
    this.birthDate,
    this.favorites,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  String get occupationString {
    final occupations = {
      'medico': S.current.jobDoctor,
      'enfermeiro': S.current.jobNurse,
      'farmaceutico': S.current.jobPharmacist,
      'estudante': S.current.jobStudent,
      'outros': S.current.jobOther,
    };

    return occupations[this.occupation] ?? S.current.jobUnknown;
  }

  bool get isProfileComplete {
    if (name?.isEmpty ?? true) {
      return false;
    }

    if (occupation?.isEmpty ?? true) {
      return false;
    }

    if (birthDate == null ||
        birthDate!.isAfter(DateTime.now()) ||
        birthDate!.isBefore(DateTime(1900))) {
      return false;
    }

    return true;
  }

  bool get isBetaTester {
    return this.betaTester ?? false;
  }
}
