import 'package:json_annotation/json_annotation.dart';
import 'resource.dart';

part 'ability.g.dart';

@JsonSerializable()
class Ability extends Resource {
  @JsonKey(name: 'generation_id')
  final int generationId;

  @JsonKey(name: 'is_main_series')
  final bool isMainSeries;

  Ability({
    required int id,
    required String identifier,
    required this.generationId,
    required this.isMainSeries,
  }) : super(id: id, identifier: identifier);

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);
  Map<String, dynamic> toJson() => _$AbilityToJson(this);
}
