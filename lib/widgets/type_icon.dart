import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/api/models/models.dart';
import 'package:pokedex/providers/resource.dart';

class TypeIcon extends ConsumerStatefulWidget {
  final int id;

  const TypeIcon({super.key, required this.id});

  @override
  ConsumerState<TypeIcon> createState() => _TypeIconState();
}

class _TypeIconState extends ConsumerState<TypeIcon> {
  late final resourceNotifier = resourceProvider<Type>(
    resource: "types",
    fromJson: Type.fromJson,
  );

  @override
  Widget build(BuildContext context) {
    final type = ref.watch(resourceNotifier(widget.id));

    return type.when(
      data:
          (data) => SvgPicture.network(
            'https://unpkg.com/@pokemonle/icons-svg@latest/icons/${data.identifier}.svg',
            width: 24, // 自定义宽度
            height: 24, // 自定义高度
            placeholderBuilder:
                (context) => SizedBox(
                  height: 24,
                  width: 24,
                  child: const Center(child: CircularProgressIndicator()),
                ), // 加载中占位
          ),
      error: (error, stackTrace) => const SizedBox.shrink(),
      loading: () => const SizedBox.shrink(),
    );
  }
}
