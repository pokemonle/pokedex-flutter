import 'package:json_annotation/json_annotation.dart';
import 'resource.dart';

part 'pokemon.g.dart';

@JsonSerializable()
class Pokemon extends LanguageResource {
  @JsonKey(name: 'species_id')
  final int speciesId;
  final int height;
  final int weight;
  @JsonKey(name: 'base_experience')
  final int baseExperience;
  final int? order;
  @JsonKey(name: 'is_default')
  final bool isDefault;

  Pokemon({
    required super.id,
    required super.identifier,
    required super.name,
    required this.speciesId,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.order,
    required this.isDefault,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);
}
