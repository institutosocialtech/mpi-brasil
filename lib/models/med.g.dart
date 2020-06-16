// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'med.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Med _$MedFromJson(Map<String, dynamic> json) {
  return Med(
    id: json['id'] as String,
    name: json['active_ingredient'] as String,
    classification:
        (json['classes'] as List)?.map((e) => e as String)?.toList(),
    conditionsToAvoid: (json['clinical_conditions_to_avoid'] as List)
        ?.map((e) => e == null
            ? null
            : MedAvoidCondition.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    alternatives: (json['alternative_therapies'] as List)
        ?.map((e) => e == null
            ? null
            : MedAlternatives.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    desprescription: json['desprescription'] as String,
    parametersToMonitor: (json['monitored_parameters'] as List)
        ?.map((e) =>
            e == null ? null : MedMonitor.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    references: (json['references'] as List)
        ?.map((e) =>
            e == null ? null : MedReference.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MedToJson(Med instance) => <String, dynamic>{
      'id': instance.id,
      'active_ingredient': instance.name,
      'classes': instance.classification,
      'clinical_conditions_to_avoid':
          instance.conditionsToAvoid?.map((e) => e?.toJson())?.toList(),
      'alternative_therapies':
          instance.alternatives?.map((e) => e?.toJson())?.toList(),
      'desprescription': instance.desprescription,
      'monitored_parameters':
          instance.parametersToMonitor?.map((e) => e?.toJson())?.toList(),
      'references': instance.references?.map((e) => e?.toJson())?.toList(),
    };

MedAvoidCondition _$MedAvoidConditionFromJson(Map<String, dynamic> json) {
  return MedAvoidCondition(
    json['critical_level'] as int,
    json['title_condition_to_avoid'] as String,
    json['description_condition_to_avoid'] as String,
    json['exception_condition_to_avoid'] as String,
  );
}

Map<String, dynamic> _$MedAvoidConditionToJson(MedAvoidCondition instance) =>
    <String, dynamic>{
      'critical_level': instance.criticalLevel,
      'title_condition_to_avoid': instance.name,
      'description_condition_to_avoid': instance.description,
      'exception_condition_to_avoid': instance.exception,
    };

MedAlternatives _$MedAlternativesFromJson(Map<String, dynamic> json) {
  return MedAlternatives(
    MedAlternatives._stringToInt(json['alternative_therapy_order'] as String) ??
        1,
    json['alternative_therapy_title'] as String,
    json['alternative_therapy_description'] as String,
  );
}

Map<String, dynamic> _$MedAlternativesToJson(MedAlternatives instance) =>
    <String, dynamic>{
      'alternative_therapy_order':
          MedAlternatives._stringFromInt(instance.order),
      'alternative_therapy_title': instance.alternative,
      'alternative_therapy_description': instance.description,
    };

MedMonitor _$MedMonitorFromJson(Map<String, dynamic> json) {
  return MedMonitor(
    json['monitor_title'] as String,
    json['monitor_description'] as String,
  );
}

Map<String, dynamic> _$MedMonitorToJson(MedMonitor instance) =>
    <String, dynamic>{
      'monitor_title': instance.parameter,
      'monitor_description': instance.description,
    };

MedReference _$MedReferenceFromJson(Map<String, dynamic> json) {
  return MedReference(
    json['reference_title'] as String,
    json['reference_url'] as String,
  );
}

Map<String, dynamic> _$MedReferenceToJson(MedReference instance) =>
    <String, dynamic>{
      'reference_title': instance.title,
      'reference_url': instance.url,
    };
