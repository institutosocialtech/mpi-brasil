import 'package:json_annotation/json_annotation.dart';
import 'package:mpibrasil/generated/l10n.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name', defaultValue: '')
  final String? name;
  @JsonKey(name: 'occupation', defaultValue: '')
  final String? occupation;
  @JsonKey(name: 'birth_date', defaultValue: null)
  final DateTime? birthDate;
  @JsonKey(name: 'favorites', defaultValue: {})
  final Map<String, bool>? favorites;
  @JsonKey(name: 'beta_tester', defaultValue: false)
  final bool? betaTester;

  const User({
    required this.id,
    this.betaTester,
    this.name,
    this.occupation,
    this.birthDate,
    this.favorites,
  });

  factory User.empty() => const User(id: '', favorites: {});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? name,
    String? occupation,
    DateTime? birthDate,
    Map<String, bool>? favorites,
    bool? betaTester,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      occupation: occupation ?? this.occupation,
      birthDate: birthDate ?? this.birthDate,
      favorites: favorites ?? this.favorites,
      betaTester: betaTester ?? this.betaTester,
    );
  }

  String get occupationString {
    final occupations = {
      'medico': S.current.jobDoctor,
      'enfermeiro': S.current.jobNurse,
      'farmaceutico': S.current.jobPharmacist,
      'estudante': S.current.jobStudent,
      'outros': S.current.jobOther,
    };

    return occupations[occupation] ?? S.current.jobUnknown;
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
    return betaTester ?? false;
  }
}
