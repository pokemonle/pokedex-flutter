import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationResource<T> {
  final int page;
  final int perPage;
  final int totalPages;
  final int totalItems;
  final List<T> data;

  PaginationResource({
    required this.page,
    required this.perPage,
    required this.totalPages,
    required this.totalItems,
    required this.data,
  });

  factory PaginationResource.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginationResourceFromJson(json, fromJsonT);
}
