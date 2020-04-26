import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drug.g.dart'; //where the json parser for this class will be generated

@JsonSerializable(explicitToJson: true)
class Drug with ChangeNotifier {
  @JsonKey(name: 'name')
  final String id;
  @JsonKey(name: 'active_ingredient')
  final String name;
  @JsonKey(name: 'classes')
  final List<String>        type;
  @JsonKey(name: 'clinical_conditions_to_avoid', defaultValue: [])
  final List<DrugAvoidCondition> avoid_conditions;
  @JsonKey(name: 'alternative_therapies', defaultValue: [])
  final List<DrugAlternatives>  alternatives;
  @JsonKey(name: 'desprescription')
  final String desprescription;
  @JsonKey(name: 'monitored_parameters', defaultValue: [])
  final List<DrugMonitor>  monitored_parameters;
  @JsonKey(name: 'references')
  final List<DrugReference>  references;

  Drug({
    this.id,
    this.name,
    this.type,
    this.avoid_conditions,
    this.alternatives,
    this.desprescription,
    this.monitored_parameters,
    this.references
  });


  factory Drug.fromJson(Map<String, dynamic> json) => _$DrugFromJson(json);
  Map<String, dynamic> toJson() => _$DrugToJson(this);


  String drugTypesToString() {
    String output = "";
    for (String s in type) {
      if (output == "")
        output = s;
      else
        output += ", " + s;
    }
    return output;
  }

}

@JsonSerializable()
class DrugAvoidCondition {
  @JsonKey(name: 'critical_level')
  final int criticalLevel;
  @JsonKey(name: 'title_condition_to_avoid')
  final String condition;
  @JsonKey(name: 'description_condition_to_avoid')
  final String description;
  @JsonKey(name: 'exception_condition_to_avoid')
  final String exception;

  DrugAvoidCondition(
    
    this.criticalLevel,
    this.condition,
    this.description,
    this.exception
    
  );
    factory DrugAvoidCondition.fromJson(Map<String, dynamic> json) => _$DrugAvoidConditionFromJson(json);

    Map<String, dynamic> toJson() => _$DrugAvoidConditionToJson(this);

}


@JsonSerializable()

class DrugAlternatives {
  @JsonKey(name: 'alternative_therapy_title')
  final String alternative;
  @JsonKey(name: 'alternative_therapy_description')
  final String description;

  DrugAlternatives(
    this.alternative,
    this.description
  );
    factory DrugAlternatives.fromJson(Map<String, dynamic> json) => _$DrugAlternativesFromJson(json);

  Map<String, dynamic> toJson() => _$DrugAlternativesToJson(this);

}


@JsonSerializable()

class DrugMonitor {
  @JsonKey(name: 'monitor_title')
  final String parameter;
  @JsonKey(name: 'monitor_description')
  final String description;

  DrugMonitor(
    this.parameter,
    this.description,
  );
    factory DrugMonitor.fromJson(Map<String, dynamic> json) => _$DrugMonitorFromJson(json);

  Map<String, dynamic> toJson() => _$DrugMonitorToJson(this);

}

@JsonSerializable()

class DrugReference {
  @JsonKey(name: 'reference_title')
  final String titulo;
  @JsonKey(name: 'reference_url')
  final String url;

  DrugReference(
    this.titulo,
    this.url
  );

    factory DrugReference.fromJson(Map<String, dynamic> json) => _$DrugReferenceFromJson(json);
    Map<String, dynamic> toJson() => _$DrugReferenceToJson(this);

}