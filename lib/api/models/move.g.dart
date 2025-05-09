// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Move _$MoveFromJson(Map<String, dynamic> json) => Move(
  id: (json['id'] as num).toInt(),
  identifier: json['identifier'] as String,
  generationId: (json['generation_id'] as num).toInt(),
  typeId: (json['type_id'] as num?)?.toInt(),
  power: (json['power'] as num?)?.toInt(),
  pp: (json['pp'] as num?)?.toInt(),
  accuracy: (json['accuracy'] as num?)?.toInt(),
  priority: (json['priority'] as num).toInt(),
  targetId: (json['target_id'] as num).toInt(),
  damageClassId: (json['damage_class_id'] as num).toInt(),
  effectId: (json['effect_id'] as num?)?.toInt(),
  effectChance: (json['effect_chance'] as num?)?.toInt(),
  contestTypeId: (json['contest_type_id'] as num?)?.toInt(),
  contestEffectId: (json['contest_effect_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$MoveToJson(Move instance) => <String, dynamic>{
  'id': instance.id,
  'identifier': instance.identifier,
  'generation_id': instance.generationId,
  'type_id': instance.typeId,
  'power': instance.power,
  'pp': instance.pp,
  'accuracy': instance.accuracy,
  'priority': instance.priority,
  'target_id': instance.targetId,
  'damage_class_id': instance.damageClassId,
  'effect_id': instance.effectId,
  'effect_chance': instance.effectChance,
  'contest_type_id': instance.contestTypeId,
  'contest_effect_id': instance.contestEffectId,
};
