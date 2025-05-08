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
