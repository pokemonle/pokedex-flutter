// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_specie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonSpecie _$PokemonSpecieFromJson(Map<String, dynamic> json) =>
    PokemonSpecie(
      id: (json['id'] as num).toInt(),
      identifier: json['identifier'] as String,
      name: json['name'] as String,
      generationId: (json['generation_id'] as num).toInt(),
      evolutionChainId: (json['evolution_chain_id'] as num?)?.toInt(),
      colorId: (json['color_id'] as num).toInt(),
      shapeId: (json['shape_id'] as num).toInt(),
      habitatId: (json['habitat_id'] as num?)?.toInt(),
      genderRate: (json['gender_rate'] as num?)?.toInt(),
      captureRate: (json['capture_rate'] as num?)?.toInt(),
      baseHappiness: (json['base_happiness'] as num?)?.toInt(),
      isBaby: json['is_baby'] as bool,
      hatchCounter: (json['hatch_counter'] as num).toInt(),
      hasGenderDifferences: json['has_gender_differences'] as bool,
      growthRateId: (json['growth_rate_id'] as num).toInt(),
      formsSwitchable: json['forms_switchable'] as bool,
      isLegendary: json['is_legendary'] as bool,
      isMythical: json['is_mythical'] as bool,
      order: (json['order'] as num).toInt(),
      conquestOrder: (json['conquest_order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PokemonSpecieToJson(PokemonSpecie instance) =>
    <String, dynamic>{
      'id': instance.id,
      'identifier': instance.identifier,
      'name': instance.name,
      'generation_id': instance.generationId,
      'evolution_chain_id': instance.evolutionChainId,
      'color_id': instance.colorId,
      'shape_id': instance.shapeId,
      'habitat_id': instance.habitatId,
      'gender_rate': instance.genderRate,
      'capture_rate': instance.captureRate,
      'base_happiness': instance.baseHappiness,
      'is_baby': instance.isBaby,
      'hatch_counter': instance.hatchCounter,
      'has_gender_differences': instance.hasGenderDifferences,
      'growth_rate_id': instance.growthRateId,
      'forms_switchable': instance.formsSwitchable,
      'is_legendary': instance.isLegendary,
      'is_mythical': instance.isMythical,
      'order': instance.order,
      'conquest_order': instance.conquestOrder,
    };
