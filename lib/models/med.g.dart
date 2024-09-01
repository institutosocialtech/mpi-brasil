// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'med.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Med _$MedFromJson(Map<String, dynamic> json) => Med(
      id: json['id'] as String,
      name: json['active_ingredient'] as String,
      classification: (json['classes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      desprescription: json['desprescription'] as String? ?? '',
      conditionsToAvoid: (json['clinical_conditions_to_avoid']
                  as List<dynamic>?)
              ?.map(
                  (e) => MedAvoidCondition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      alternatives: (json['alternative_therapies'] as List<dynamic>?)
              ?.map((e) => MedAlternatives.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      parametersToMonitor: (json['monitored_parameters'] as List<dynamic>?)
              ?.map((e) => MedMonitor.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      references: (json['references'] as List<dynamic>?)
              ?.map((e) => MedReference.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$MedToJson(Med instance) => <String, dynamic>{
      'id': instance.id,
      'active_ingredient': instance.name,
      'classes': instance.classification,
      'desprescription': instance.desprescription,
      'clinical_conditions_to_avoid':
          instance.conditionsToAvoid?.map((e) => e.toJson()).toList(),
      'alternative_therapies':
          instance.alternatives?.map((e) => e.toJson()).toList(),
      'monitored_parameters':
          instance.parametersToMonitor?.map((e) => e.toJson()).toList(),
      'references': instance.references?.map((e) => e.toJson()).toList(),
    };

MedAvoidCondition _$MedAvoidConditionFromJson(Map<String, dynamic> json) =>
    MedAvoidCondition(
      (json['critical_level'] as num?)?.toInt() ?? -1,
      json['title_condition_to_avoid'] as String? ?? '',
      json['description_condition_to_avoid'] as String? ?? '',
      json['exception_condition_to_avoid'] as String? ?? '',
    );

Map<String, dynamic> _$MedAvoidConditionToJson(MedAvoidCondition instance) =>
    <String, dynamic>{
      'critical_level': instance.criticalLevel,
      'title_condition_to_avoid': instance.name,
      'description_condition_to_avoid': instance.description,
      'exception_condition_to_avoid': instance.exception,
    };

MedAlternatives _$MedAlternativesFromJson(Map<String, dynamic> json) =>
    MedAlternatives(
      json['alternative_therapy_order'] == null
          ? 1
          : MedAlternatives._stringToInt(json['alternative_therapy_order']),
      json['alternative_therapy_title'] as String,
      json['alternative_therapy_description'] as String,
    );

Map<String, dynamic> _$MedAlternativesToJson(MedAlternatives instance) =>
    <String, dynamic>{
      'alternative_therapy_order': MedAlternatives._intToString(instance.order),
      'alternative_therapy_title': instance.alternative,
      'alternative_therapy_description': instance.description,
    };

MedMonitor _$MedMonitorFromJson(Map<String, dynamic> json) => MedMonitor(
      json['monitor_title'] as String?,
      json['monitor_description'] as String?,
    );

Map<String, dynamic> _$MedMonitorToJson(MedMonitor instance) =>
    <String, dynamic>{
      'monitor_title': instance.parameter,
      'monitor_description': instance.description,
    };

MedReference _$MedReferenceFromJson(Map<String, dynamic> json) => MedReference(
      json['reference_title'] as String?,
      json['reference_url'] as String?,
    );

Map<String, dynamic> _$MedReferenceToJson(MedReference instance) =>
    <String, dynamic>{
      'reference_title': instance.title,
      'reference_url': instance.url,
    };
