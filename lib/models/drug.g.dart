// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Drug _$DrugFromJson(Map<String, dynamic> json) {
  return Drug(
    id: json['name'] as String,
    name: json['active_ingredient'] as String,
    type: (json['classes'] as List)?.map((e) => e as String)?.toList(),
    avoid_conditions: (json['clinical_conditions_to_avoid'] as List)
            ?.map((e) => e == null
                ? null
                : DrugAvoidCondition.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    alternatives: (json['alternative_therapies'] as List)
            ?.map((e) => e == null
                ? null
                : DrugAlternatives.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    desprescription: json['desprescription'] as String,
    monitored_parameters: (json['monitored_parameters'] as List)
            ?.map((e) => e == null
                ? null
                : DrugMonitor.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    references: (json['references'] as List)
        ?.map((e) => e == null
            ? null
            : DrugReference.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DrugToJson(Drug instance) => <String, dynamic>{
      'name': instance.id,
      'active_ingredient': instance.name,
      'classes': instance.type,
      'clinical_conditions_to_avoid':
          instance.avoid_conditions?.map((e) => e?.toJson())?.toList(),
      'alternative_therapies':
          instance.alternatives?.map((e) => e?.toJson())?.toList(),
      'desprescription': instance.desprescription,
      'monitored_parameters':
          instance.monitored_parameters?.map((e) => e?.toJson())?.toList(),
      'references': instance.references?.map((e) => e?.toJson())?.toList(),
    };

DrugAvoidCondition _$DrugAvoidConditionFromJson(Map<String, dynamic> json) {
  return DrugAvoidCondition(
    json['critical_level'] as int,
    json['title_condition_to_avoid'] as String,
    json['description_condition_to_avoid'] as String,
    json['exception_condition_to_avoid'] as String,
  );
}

Map<String, dynamic> _$DrugAvoidConditionToJson(DrugAvoidCondition instance) =>
    <String, dynamic>{
      'critical_level': instance.criticalLevel,
      'title_condition_to_avoid': instance.condition,
      'description_condition_to_avoid': instance.description,
      'exception_condition_to_avoid': instance.exception,
    };

DrugAlternatives _$DrugAlternativesFromJson(Map<String, dynamic> json) {
  return DrugAlternatives(
    json['alternative_therapy_title'] as String,
    json['alternative_therapy_description'] as String,
  );
}

Map<String, dynamic> _$DrugAlternativesToJson(DrugAlternatives instance) =>
    <String, dynamic>{
      'alternative_therapy_title': instance.alternative,
      'alternative_therapy_description': instance.description,
    };

DrugMonitor _$DrugMonitorFromJson(Map<String, dynamic> json) {
  return DrugMonitor(
    json['monitor_title'] as String,
    json['monitor_description'] as String,
  );
}

Map<String, dynamic> _$DrugMonitorToJson(DrugMonitor instance) =>
    <String, dynamic>{
      'monitor_title': instance.parameter,
      'monitor_description': instance.description,
    };

DrugReference _$DrugReferenceFromJson(Map<String, dynamic> json) {
  return DrugReference(
    json['reference_title'] as String,
    json['reference_url'] as String,
  );
}

Map<String, dynamic> _$DrugReferenceToJson(DrugReference instance) =>
    <String, dynamic>{
      'reference_title': instance.titulo,
      'reference_url': instance.url,
    };
