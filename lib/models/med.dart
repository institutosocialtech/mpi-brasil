import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'med.g.dart'; //where the json parser for this class will be generated

@JsonSerializable(explicitToJson: true)
class Med with ChangeNotifier {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'active_ingredient')
  final String name;
  @JsonKey(name: 'classes', defaultValue: [])
  final List<String>? classification;
  @JsonKey(name: 'desprescription', defaultValue: '')
  final String? desprescription;
  @JsonKey(name: 'clinical_conditions_to_avoid', defaultValue: [])
  final List<MedAvoidCondition>? conditionsToAvoid;
  @JsonKey(name: 'alternative_therapies', defaultValue: [])
  final List<MedAlternatives>? alternatives;
  @JsonKey(name: 'monitored_parameters', defaultValue: [])
  final List<MedMonitor>? parametersToMonitor;
  @JsonKey(name: 'references', defaultValue: [])
  final List<MedReference>? references;

  Med({
    required this.id,
    required this.name,
    this.classification,
    this.desprescription,
    this.conditionsToAvoid,
    this.alternatives,
    this.parametersToMonitor,
    this.references,
  });

  factory Med.fromJson(Map<String, dynamic> json) => _$MedFromJson(json);
  Map<String, dynamic> toJson() => _$MedToJson(this);

  String medTypesToString() {
    return classification?.join(', ') ?? '';
  }

  bool hasConditionsToAvoid() {
    return conditionsToAvoid != null && conditionsToAvoid!.isNotEmpty;
  }

  bool hasDesprescribing() {
    return desprescription != null && desprescription!.isNotEmpty;
  }

  bool hasAlternativeTherapy() {
    return alternatives != null && alternatives!.isNotEmpty;
  }

  bool hasMonitoredParameters() {
    return parametersToMonitor != null && parametersToMonitor!.isNotEmpty;
  }

  bool hasReferences() {
    return references != null && references!.isNotEmpty;
  }
}

@JsonSerializable()
class MedAvoidCondition {
  @JsonKey(name: 'critical_level', defaultValue: -1)
  final int? criticalLevel;
  @JsonKey(name: 'title_condition_to_avoid', defaultValue: '')
  final String? name;
  @JsonKey(name: 'description_condition_to_avoid', defaultValue: '')
  final String? description;
  @JsonKey(name: 'exception_condition_to_avoid', defaultValue: '')
  final String? exception;

  MedAvoidCondition(
    this.criticalLevel,
    this.name,
    this.description,
    this.exception,
  );

  factory MedAvoidCondition.fromJson(Map<String, dynamic> json) =>
      _$MedAvoidConditionFromJson(json);

  Map<String, dynamic> toJson() => _$MedAvoidConditionToJson(this);

  bool hasException() {
    return exception != null && exception!.isNotEmpty;
  }
}

@JsonSerializable()
class MedAlternatives {
  @JsonKey(
      name: 'alternative_therapy_order',
      defaultValue: 1,
      fromJson: _stringToInt,
      toJson: _intToString)
  final int order;
  @JsonKey(name: 'alternative_therapy_title')
  final String alternative;
  @JsonKey(name: 'alternative_therapy_description')
  final String description;

  MedAlternatives(
    this.order,
    this.alternative,
    this.description,
  );

  factory MedAlternatives.fromJson(Map<String, dynamic> json) =>
      _$MedAlternativesFromJson(json);

  Map<String, dynamic> toJson() => _$MedAlternativesToJson(this);

  static int _stringToInt(dynamic number) {
    if (number is num) return number.toInt();
    if (number is String) return int.tryParse(number)?.toInt() ?? 0;

    return -1;
  }

  static dynamic _intToString(int number) => number.toString();
}

@JsonSerializable()
class MedMonitor {
  @JsonKey(name: 'monitor_title')
  final String? parameter;
  @JsonKey(name: 'monitor_description')
  final String? description;

  MedMonitor(
    this.parameter,
    this.description,
  );

  factory MedMonitor.fromJson(Map<String, dynamic> json) =>
      _$MedMonitorFromJson(json);

  Map<String, dynamic> toJson() => _$MedMonitorToJson(this);
}

@JsonSerializable()
class MedReference {
  @JsonKey(name: 'reference_title')
  final String? title;
  @JsonKey(name: 'reference_url')
  final String? url;

  MedReference(this.title, this.url);

  factory MedReference.fromJson(Map<String, dynamic> json) =>
      _$MedReferenceFromJson(json);

  Map<String, dynamic> toJson() => _$MedReferenceToJson(this);
}
