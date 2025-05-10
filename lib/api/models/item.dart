import 'package:json_annotation/json_annotation.dart';
import 'resource.dart';

part 'item.g.dart';

@JsonSerializable()
class Item extends LanguageResource {
  final int cost;

  @JsonKey(name: 'fling_power')
  final int? flingPower;

  // 若需启用其他字段可取消注释
  // @JsonKey(name: 'fling_effect')
  // final String? flingEffect;

  // @JsonKey(name: 'natural_gift_power')
  // final int? naturalGiftPower;

  Item({
    required super.id,
    required super.identifier,
    required super.name,
    required this.cost,
    required this.flingPower,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
