import 'package:json_annotation/json_annotation.dart';
import 'resource.dart';

part 'ability.g.dart';

@JsonSerializable()
class Ability extends LanguageResource {
  @JsonKey(name: 'generation_id')
  final int generationId;

  @JsonKey(name: 'is_main_series')
  final bool isMainSeries;

  Ability({
    required super.id,
    required super.identifier,
    required super.name,
    required this.generationId,
    required this.isMainSeries,
  });

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);
  Map<String, dynamic> toJson() => _$AbilityToJson(this);
}
