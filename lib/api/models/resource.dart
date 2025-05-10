import 'package:json_annotation/json_annotation.dart';

part 'resource.g.dart';

@JsonSerializable()
class Resource {
  final int id;
  final String identifier;

  Resource({required this.id, required this.identifier});

  factory Resource.fromJson(Map<String, dynamic> json) =>
      _$ResourceFromJson(json);
  Map<String, dynamic> toJson() => _$ResourceToJson(this);
}

// 定义一个泛型 Language<T> 比 T 多一个字段，同样实现 json
@JsonSerializable()
class LanguageResource extends Resource {
  final String name;

  LanguageResource({
    required super.id,
    required super.identifier,
    required this.name,
  });

  factory LanguageResource.fromJson(Map<String, dynamic> json) =>
      _$LanguageResourceFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$LanguageResourceToJson(this);
}
