// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Resource _$ResourceFromJson(Map<String, dynamic> json) => Resource(
  id: (json['id'] as num).toInt(),
  identifier: json['identifier'] as String,
);

Map<String, dynamic> _$ResourceToJson(Resource instance) => <String, dynamic>{
  'id': instance.id,
  'identifier': instance.identifier,
};

LanguageResource _$LanguageResourceFromJson(Map<String, dynamic> json) =>
    LanguageResource(
      id: (json['id'] as num).toInt(),
      identifier: json['identifier'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$LanguageResourceToJson(LanguageResource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'identifier': instance.identifier,
      'name': instance.name,
    };
