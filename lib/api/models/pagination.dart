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
  ) {
    // 手动解析，处理可能为 null 的字段
    return PaginationResource<T>(
      page: (json['page'] as num?)?.toInt() ?? 1,
      perPage: (json['per_page'] as num?)?.toInt() ?? 15,
      totalPages: (json['total_pages'] as num?)?.toInt() ?? 1,
      totalItems: (json['total_items'] as num?)?.toInt() ?? 0,
      data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList() ?? [],
    );
  }
}
