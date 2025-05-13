import 'package:json_annotation/json_annotation.dart';
import 'resource.dart';

part 'type.g.dart';

@JsonSerializable()
class Type extends LanguageResource {
  @JsonKey(name: 'generation_id')
  final int generationId;

  @JsonKey(name: 'damage_class_id')
  final int? damageClassId;

  Type({
    required super.id,
    required super.identifier,
    required super.name,
    required this.generationId,
    this.damageClassId,
  });

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TypeToJson(this);
}
