import 'package:json_annotation/json_annotation.dart';
import 'resource.dart';

part 'language.g.dart';

@JsonSerializable()
class Language extends Resource {
  @JsonKey(name: 'iso3166')
  final String iso3166;

  @JsonKey(name: 'iso639')
  final String iso639;

  @JsonKey(name: 'official')
  final bool official;

  @JsonKey(name: 'order')
  final int order;

  Language({
    required super.id,
    required super.identifier,
    required this.iso3166,
    required this.iso639,
    required this.official,
    required this.order,
  });

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}

@JsonSerializable()
class LanguageName {
  @JsonKey(name: 'language_id')
  final int languageId;
  @JsonKey(name: 'local_language_id')
  final int localLanguageId;

  final String name;

  LanguageName({
    required this.languageId,
    required this.localLanguageId,
    required this.name,
  });

  factory LanguageName.fromJson(Map<String, dynamic> json) =>
      _$LanguageNameFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageNameToJson(this);
}
