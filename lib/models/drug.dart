import 'package:flutter/foundation.dart';

class Drug with ChangeNotifier {

  final String             name;
  final List<String>       type;
  final bool               avoidIndependently;
  final String             avoidIndependentlyReason;
  final String             avoidIndependentlyExceptions;
  final bool               avoidSpecifically;
  final Map<String,String> avoidSpecificallyConditions;
  final Map<String,String> alternatives;
  final String             desprescription;
  final Map<String,String> monitoredParameters;
  final Map<String,String> references;

  Drug(
    this.name,
    this.type,
    this.avoidIndependently,
    this.avoidIndependentlyReason,
    this.avoidIndependentlyExceptions,
    this.avoidSpecifically,
    this.avoidSpecificallyConditions,
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
