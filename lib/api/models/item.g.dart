// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
  id: (json['id'] as num).toInt(),
  identifier: json['identifier'] as String,
  cost: (json['cost'] as num).toInt(),
  flingPower: (json['fling_power'] as num).toInt(),
);

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
  'id': instance.id,
  'identifier': instance.identifier,
  'cost': instance.cost,
  'fling_power': instance.flingPower,
};
