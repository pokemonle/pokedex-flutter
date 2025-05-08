// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pokemon _$PokemonFromJson(Map<String, dynamic> json) => Pokemon(
  id: (json['id'] as num).toInt(),
  identifier: json['identifier'] as String,
  speciesId: (json['speciesId'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  weight: (json['weight'] as num).toInt(),
  baseExperience: (json['baseExperience'] as num).toInt(),
  order: (json['order'] as num).toInt(),
  isDefault: (json['isDefault'] as num).toInt(),
);

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
  'id': instance.id,
  'identifier': instance.identifier,
  'speciesId': instance.speciesId,
  'height': instance.height,
  'weight': instance.weight,
  'baseExperience': instance.baseExperience,
  'order': instance.order,
  'isDefault': instance.isDefault,
};
