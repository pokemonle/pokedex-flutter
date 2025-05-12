// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ability _$AbilityFromJson(Map<String, dynamic> json) => Ability(
  id: (json['id'] as num).toInt(),
  identifier: json['identifier'] as String,
  name: json['name'] as String,
  generationId: (json['generation_id'] as num).toInt(),
  isMainSeries: json['is_main_series'] as bool,
);

Map<String, dynamic> _$AbilityToJson(Ability instance) => <String, dynamic>{
  'id': instance.id,
  'identifier': instance.identifier,
  'name': instance.name,
  'generation_id': instance.generationId,
  'is_main_series': instance.isMainSeries,
};

AbilityWithSlot _$AbilityWithSlotFromJson(Map<String, dynamic> json) =>
    AbilityWithSlot(
      id: (json['id'] as num).toInt(),
      identifier: json['identifier'] as String,
      name: json['name'] as String,
      generationId: (json['generation_id'] as num).toInt(),
      isMainSeries: json['is_main_series'] as bool,
      slot: (json['slot'] as num).toInt(),
      isHidden: json['is_hidden'] as bool,
    );

Map<String, dynamic> _$AbilityWithSlotToJson(AbilityWithSlot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'identifier': instance.identifier,
      'name': instance.name,
      'generation_id': instance.generationId,
      'is_main_series': instance.isMainSeries,
      'slot': instance.slot,
      'is_hidden': instance.isHidden,
    };
