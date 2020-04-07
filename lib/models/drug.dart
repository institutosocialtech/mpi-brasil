import 'package:flutter/foundation.dart';

class Drug with ChangeNotifier {
  final int                 id;
  final String              name;
  final List<String>        type;
  final List<DrugAvoidCondition> avoidConditions;
  final List<DrugAlternatives>  alternatives;
  final String              desprescription;
  final List<DrugMonitor>  monitoredParameters;
  final List<DrugReference>  references;

  Drug(
    this.id,
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
}