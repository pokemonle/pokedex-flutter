import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TypeIcon extends StatelessWidget {
  final String type;

  const TypeIcon({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      'https://unpkg.com/@pokemonle/icons-svg@latest/icons/$type.svg',
      width: 24, // 自定义宽度
      height: 24, // 自定义高度
      placeholderBuilder: (context) => CircularProgressIndicator(), // 加载中占位
    );
  }
}
