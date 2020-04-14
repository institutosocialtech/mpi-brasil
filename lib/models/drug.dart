import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drug.g.dart'; //where the json parser for this class will be generated

@JsonSerializable(explicitToJson: true)
class Drug with ChangeNotifier {
  final String                 id;
  final String              name;
  final List<String>        type;
  final List<DrugAvoidCondition> avoid_conditions;
  final List<DrugAlternatives>  alternatives;
  final String              desprescription;
  final List<DrugMonitor>  monitored_parameters;
  final List<DrugReference>  references;

  Drug(
    this.id,
    this.name,
    this.type,
    this.avoid_conditions,
    this.alternatives,
    this.desprescription,
    this.monitored_parameters,
    this.references
  );


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

  final int criticalLevel;
  final String condition;
  final String description;
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
  final String alternative;
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
  final String parameter;
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
  final String titulo;
  final String autores;
  final String editora;
  final String data;
  final String url;

  DrugReference(
    this.titulo,
    this.autores,
    this.editora,
    this.data,
    this.url
  );
    factory DrugReference.fromJson(Map<String, dynamic> json) => _$DrugReferenceFromJson(json);

  Map<String, dynamic> toJson() => _$DrugReferenceToJson(this);

}