// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ability _$AbilityFromJson(Map<String, dynamic> json) => Ability(
  id: (json['id'] as num).toInt(),
  identifier: json['identifier'] as String,
  generationId: (json['generation_id'] as num).toInt(),
  isMainSeries: json['is_main_series'] as bool,
);

Map<String, dynamic> _$AbilityToJson(Ability instance) => <String, dynamic>{
  'id': instance.id,
  'identifier': instance.identifier,
  'generation_id': instance.generationId,
  'is_main_series': instance.isMainSeries,
};
