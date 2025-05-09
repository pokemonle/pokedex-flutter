// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
  id: (json['id'] as num).toInt(),
  identifier: json['identifier'] as String,
  iso3166: json['iso3166'] as String,
  iso639: json['iso639'] as String,
  official: json['official'] as bool,
  order: (json['order'] as num).toInt(),
);

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
  'id': instance.id,
  'identifier': instance.identifier,
  'iso3166': instance.iso3166,
  'iso639': instance.iso639,
  'official': instance.official,
  'order': instance.order,
};
