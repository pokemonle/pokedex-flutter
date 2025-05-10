import 'package:json_annotation/json_annotation.dart';
import 'resource.dart';

part 'move.g.dart';

@JsonSerializable()
class Move extends LanguageResource {
  @JsonKey(name: 'generation_id')
  final int generationId;

  @JsonKey(name: 'type_id')
  final int? typeId;
  final int? power;
  final int? pp;
  final int? accuracy;
  final int priority;

  @JsonKey(name: 'target_id')
  final int targetId;

  @JsonKey(name: 'damage_class_id')
  final int damageClassId;

  @JsonKey(name: 'effect_id')
  final int? effectId;

  @JsonKey(name: 'effect_chance')
  final int? effectChance;

  @JsonKey(name: 'contest_type_id')
  final int? contestTypeId;

  @JsonKey(name: 'contest_effect_id')
  final int? contestEffectId;

  Move({
    required super.id,
    required super.identifier,
    required super.name,
    required this.generationId,
    required this.typeId,
    required this.power,
    required this.pp,
    required this.accuracy,
    required this.priority,
    required this.targetId,
    required this.damageClassId,
    required this.effectId,
    required this.effectChance,
    required this.contestTypeId,
    required this.contestEffectId,
  });

  factory Move.fromJson(Map<String, dynamic> json) => _$MoveFromJson(json);
  Map<String, dynamic> toJson() => _$MoveToJson(this);
}
