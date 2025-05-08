// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationResource<T> _$PaginationResourceFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => PaginationResource<T>(
  page: (json['page'] as num).toInt(),
  perPage: (json['perPage'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  totalItems: (json['totalItems'] as num).toInt(),
  data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
);

Map<String, dynamic> _$PaginationResourceToJson<T>(
  PaginationResource<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'page': instance.page,
  'perPage': instance.perPage,
  'totalPages': instance.totalPages,
  'totalItems': instance.totalItems,
  'data': instance.data.map(toJsonT).toList(),
};
