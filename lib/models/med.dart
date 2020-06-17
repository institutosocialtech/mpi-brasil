import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'med.g.dart'; //where the json parser for this class will be generated

@JsonSerializable(explicitToJson: true)
class Med with ChangeNotifier {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'active_ingredient')
  final String name;
  @JsonKey(name: 'classes')
  final List<String> classification;
  @JsonKey(name: 'clinical_conditions_to_avoid', defaultValue: null)
  final List<MedAvoidCondition> conditionsToAvoid;
  @JsonKey(name: 'alternative_therapies', defaultValue: null)
  final List<MedAlternatives> alternatives;
  @JsonKey(name: 'desprescription')
  final String desprescription;
  @JsonKey(name: 'monitored_parameters', defaultValue: null)
  final List<MedMonitor> parametersToMonitor;
  @JsonKey(name: 'references')
  final List<MedReference> references;
  
  Med({
    this.id,
    this.name,
    this.classification,
    this.conditionsToAvoid,
    this.alternatives,
    this.desprescription,
    this.parametersToMonitor,
    this.references
  });

  factory Med.fromJson(Map<String, dynamic> json) => _$MedFromJson(json);
  Map<String, dynamic> toJson() => _$MedToJson(this);

  String medTypesToString() {
    String output = "";
    for (String s in classification) {
      if (output == "")
        output = s;
      else
        output += ", " + s;
    }
    return output;
  }

}

@JsonSerializable()
class MedAvoidCondition {
  @JsonKey(name: 'critical_level')
  final int criticalLevel;
  @JsonKey(name: 'title_condition_to_avoid')
  final String name;
  @JsonKey(name: 'description_condition_to_avoid')
  final String description;
  @JsonKey(name: 'exception_condition_to_avoid')
  final String exception;

  MedAvoidCondition(
    
    this.criticalLevel,
    this.name,
    this.description,
    this.exception
    
  );
    factory MedAvoidCondition.fromJson(Map<String, dynamic> json) => _$MedAvoidConditionFromJson(json);

    Map<String, dynamic> toJson() => _$MedAvoidConditionToJson(this);

}


@JsonSerializable()

class MedAlternatives {
  @JsonKey(name: 'alternative_therapy_order', defaultValue: 1, fromJson: _stringToInt, toJson: _stringFromInt)
  final int order;
  @JsonKey(name: 'alternative_therapy_title')
  final String alternative;
  @JsonKey(name: 'alternative_therapy_description')
  final String description;

  MedAlternatives(
    this.order,
    this.alternative,
    this.description
  );
    factory MedAlternatives.fromJson(Map<String, dynamic> json) => _$MedAlternativesFromJson(json);

  Map<String, dynamic> toJson() => _$MedAlternativesToJson(this);
  static int _stringToInt(String number) => number == null ? null : int.parse(number);
  static String _stringFromInt(int number) => number?.toString();

}


@JsonSerializable()

class MedMonitor {
  @JsonKey(name: 'monitor_title')
  final String parameter;
  @JsonKey(name: 'monitor_description')
  final String description;

  MedMonitor(
    this.parameter,
    this.description,
  );
    factory MedMonitor.fromJson(Map<String, dynamic> json) => _$MedMonitorFromJson(json);

  Map<String, dynamic> toJson() => _$MedMonitorToJson(this);

}

@JsonSerializable()

class MedReference {
  @JsonKey(name: 'reference_title')
  final String title;
  @JsonKey(name: 'reference_url')
  final String url;

  MedReference(
    this.title,
    this.url
  );

    factory MedReference.fromJson(Map<String, dynamic> json) => _$MedReferenceFromJson(json);
    Map<String, dynamic> toJson() => _$MedReferenceToJson(this);

}