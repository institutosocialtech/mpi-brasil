import 'package:flutter/foundation.dart';

class Drug with ChangeNotifier {

  final String              name;
  final List<String>        type;
  final List<DrugAvoidCondition> avoidConditions;
  final List<DrugAlternatives>  alternatives;
  final String              desprescription;
  final List<DrugMonitor>  monitoredParameters;
  final List<DrugReference>  references;

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


class DrugMonitor {
  final String parameter;
  final String description;

  DrugMonitor(
    this.parameter,
    this.description,
  );
}

class DrugReference {
  final String description;
  final String url;

  DrugReference(
    this.description,
    this.url
  );
}