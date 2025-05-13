import 'package:json_annotation/json_annotation.dart';

part 'flavor_text.g.dart';

@JsonSerializable()
class FlavorText {
  final String description;
  final int language;
  final int? version;
  final int? versionGroup;

  FlavorText({
    required this.description,
    required this.language,
    this.version,
    this.versionGroup,
  });

  factory FlavorText.fromJson(Map<String, dynamic> json) =>
      _$FlavorTextFromJson(json);
  Map<String, dynamic> toJson() => _$FlavorTextToJson(this);
}
