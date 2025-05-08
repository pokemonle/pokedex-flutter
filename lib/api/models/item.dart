import 'package:json_annotation/json_annotation.dart';
import 'resource.dart';

part 'item.g.dart';

@JsonSerializable()
class Item extends Resource {
  final int cost;

  @JsonKey(name: 'fling_power')
  final int flingPower;

  // 若需启用其他字段可取消注释
  // @JsonKey(name: 'fling_effect')
  // final String? flingEffect;

  // @JsonKey(name: 'natural_gift_power')
  // final int? naturalGiftPower;

  Item({
    required int id,
    required String identifier,
    required this.cost,
    required this.flingPower,
    // this.flingEffect,
    // this.naturalGiftPower,
  }) : super(id: id, identifier: identifier);

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
