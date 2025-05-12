// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pokemon _$PokemonFromJson(Map<String, dynamic> json) => Pokemon(
  id: (json['id'] as num).toInt(),
  identifier: json['identifier'] as String,
  name: json['name'] as String,
  speciesId: (json['species_id'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  weight: (json['weight'] as num).toInt(),
  baseExperience: (json['base_experience'] as num).toInt(),
  order: (json['order'] as num?)?.toInt(),
  isDefault: json['is_default'] as bool,
);

Map<String, dynamic> _$PokemonToJson(Pokemon instance) => <String, dynamic>{
  'id': instance.id,
  'identifier': instance.identifier,
  'name': instance.name,
  'species_id': instance.speciesId,
  'height': instance.height,
  'weight': instance.weight,
  'base_experience': instance.baseExperience,
  'order': instance.order,
  'is_default': instance.isDefault,
};
