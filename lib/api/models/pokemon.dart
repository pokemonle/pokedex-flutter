import 'package:json_annotation/json_annotation.dart';
import 'resource.dart';

part 'pokemon.g.dart';

@JsonSerializable()
class Pokemon extends Resource {
  final int speciesId;
  final int height;
  final int weight;
  final int baseExperience;
  final int order;
  final int isDefault;

  Pokemon({
    required int id,
    required String identifier,
    required this.speciesId,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.order,
    required this.isDefault,
  }) : super(id: id, identifier: identifier);

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);
}
