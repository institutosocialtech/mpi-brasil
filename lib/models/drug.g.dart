// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Drug _$DrugFromJson(Map<String, dynamic> json) {
  return Drug(
    json['id'] as String,
    json['name'] as String,
    (json['type'] as List)?.map((e) => e as String)?.toList(),
    (json['avoid_conditions'] as List)
        ?.map((e) => e == null
            ? null
            : DrugAvoidCondition.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['alternatives'] as List)
        ?.map((e) => e == null
            ? null
            : DrugAlternatives.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['desprescription'] as String,
    (json['monitored_parameters'] as List)
        ?.map((e) =>
            e == null ? null : DrugMonitor.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['references'] as List)
        ?.map((e) => e == null
            ? null
            : DrugReference.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DrugToJson(Drug instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'avoid_conditions':
          instance.avoid_conditions?.map((e) => e?.toJson())?.toList(),
      'alternatives': instance.alternatives?.map((e) => e?.toJson())?.toList(),
      'desprescription': instance.desprescription,
      'monitored_parameters':
          instance.monitored_parameters?.map((e) => e?.toJson())?.toList(),
      'references': instance.references?.map((e) => e?.toJson())?.toList(),
    };

DrugAvoidCondition _$DrugAvoidConditionFromJson(Map<String, dynamic> json) {
  return DrugAvoidCondition(
    json['criticalLevel'] as int,
    json['condition'] as String,
    json['description'] as String,
    json['exception'] as String,
  );
}

Map<String, dynamic> _$DrugAvoidConditionToJson(DrugAvoidCondition instance) =>
    <String, dynamic>{
      'criticalLevel': instance.criticalLevel,
      'condition': instance.condition,
      'description': instance.description,
      'exception': instance.exception,
    };

DrugAlternatives _$DrugAlternativesFromJson(Map<String, dynamic> json) {
  return DrugAlternatives(
    json['alternative'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$DrugAlternativesToJson(DrugAlternatives instance) =>
    <String, dynamic>{
      'alternative': instance.alternative,
      'description': instance.description,
    };

DrugMonitor _$DrugMonitorFromJson(Map<String, dynamic> json) {
  return DrugMonitor(
    json['parameter'] as String,
    json['description'] as String,
  );
}

Map<String, dynamic> _$DrugMonitorToJson(DrugMonitor instance) =>
    <String, dynamic>{
      'parameter': instance.parameter,
      'description': instance.description,
    };

DrugReference _$DrugReferenceFromJson(Map<String, dynamic> json) {
  return DrugReference(
    json['titulo'] as String,
    json['autores'] as String,
    json['editora'] as String,
    json['data'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$DrugReferenceToJson(DrugReference instance) =>
    <String, dynamic>{
      'titulo': instance.titulo,
      'autores': instance.autores,
      'editora': instance.editora,
      'data': instance.data,
      'url': instance.url,
    };
