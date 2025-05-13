// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Type _$TypeFromJson(Map<String, dynamic> json) => Type(
  id: (json['id'] as num).toInt(),
  identifier: json['identifier'] as String,
  name: json['name'] as String,
  generationId: (json['generation_id'] as num).toInt(),
  damageClassId: (json['damage_class_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
  'id': instance.id,
  'identifier': instance.identifier,
  'name': instance.name,
  'generation_id': instance.generationId,
  'damage_class_id': instance.damageClassId,
};
