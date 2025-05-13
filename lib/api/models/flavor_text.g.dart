// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flavor_text.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlavorText _$FlavorTextFromJson(Map<String, dynamic> json) => FlavorText(
  description: json['description'] as String,
  language: (json['language'] as num).toInt(),
  version: (json['version'] as num?)?.toInt(),
  versionGroup: (json['versionGroup'] as num?)?.toInt(),
);

Map<String, dynamic> _$FlavorTextToJson(FlavorText instance) =>
    <String, dynamic>{
      'description': instance.description,
      'language': instance.language,
      'version': instance.version,
      'versionGroup': instance.versionGroup,
    };
