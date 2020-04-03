import 'package:flutter/foundation.dart';

class Drug with ChangeNotifier {

  final String              name;
  final List<String>        type;
  final List<DrugAvoidCondition> avoidConditions;
  final List<DrugAlternatives>  alternatives;
  final String              desprescription;
  final Map<String,String>  monitoredParameters;
  final Map<String,String>  references;

  Drug(
    this.name,
    this.type,
    this.avoidConditions,
    this.alternatives,
    this.desprescription,
    this.monitoredParameters,
    this.references
  );

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

class DrugAvoidCondition {

  final bool independent;
  final String condition;
  final String description;
  final String exception;

  DrugAvoidCondition(
    
    this.independent,
    this.condition,
    this.description,
    this.exception
    
  );

}


class DrugAlternatives {
  final String alternative;
  final String description;

  DrugAlternatives(
    this.alternative,
    this.description
  );
}