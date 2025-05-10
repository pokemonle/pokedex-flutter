import 'package:json_annotation/json_annotation.dart';
import 'resource.dart';

part 'pokemon_specie.g.dart';

@JsonSerializable()
class PokemonSpecie extends LanguageResource {
  @JsonKey(name: 'generation_id')
  final int generationId;
  @JsonKey(name: 'evolution_chain_id')
  final int? evolutionChainId;
  @JsonKey(name: 'color_id')
  final int colorId;
  @JsonKey(name: 'shape_id')
  final int shapeId;
  @JsonKey(name: 'habitat_id')
  final int? habitatId;
  @JsonKey(name: 'gender_rate')
  final int? genderRate;
  @JsonKey(name: 'capture_rate')
  final int? captureRate;
  @JsonKey(name: 'base_happiness')
  final int? baseHappiness;
  @JsonKey(name: 'is_baby')
  final bool isBaby;
  @JsonKey(name: 'hatch_counter')
  final int hatchCounter;
  @JsonKey(name: 'has_gender_differences')
  final bool hasGenderDifferences;
  @JsonKey(name: 'growth_rate_id')
  final int growthRateId;
  @JsonKey(name: 'forms_switchable')
  final bool formsSwitchable;
  @JsonKey(name: 'is_legendary')
  final bool isLegendary;
  @JsonKey(name: 'is_mythical')
  final bool isMythical;
  @JsonKey(name: 'order')
  final int order;
  @JsonKey(name: 'conquest_order')
  final int? conquestOrder;

  PokemonSpecie({
    required super.id,
    required super.identifier,
    required super.name,
    required this.generationId,
    required this.evolutionChainId,
    required this.colorId,
    required this.shapeId,
    required this.habitatId,
    required this.genderRate,
    required this.captureRate,
    required this.baseHappiness,
    required this.isBaby,
    required this.hatchCounter,
    required this.hasGenderDifferences,
    required this.growthRateId,
    required this.formsSwitchable,
    required this.isLegendary,
    required this.isMythical,
    required this.order,
    required this.conquestOrder,
  });

  factory PokemonSpecie.fromJson(Map<String, dynamic> json) =>
      _$PokemonSpecieFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonSpecieToJson(this);
}
