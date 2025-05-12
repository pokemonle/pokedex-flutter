import 'package:flutter/material.dart';

class ResourceWidget extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final IconData? icon;
  final bool rightIcon;
  final VoidCallback? onTap;
  final int tapDelay;
  final String title;
  const ResourceWidget({
    super.key,
    this.margin,
    this.padding,
    this.icon,
    this.rightIcon = false,
    this.onTap,
    this.tapDelay = 150,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin:
          margin ?? const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant, // 使用 outlineVariant 作为边框色
          width: 1,
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          child: InkWell(
            onTap: () async {
              await Future.delayed(Duration(milliseconds: tapDelay));
              onTap?.call();
            },
            child: Padding(
              padding: padding ?? const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: icon != null ? Icon(icon) : null,
                      title: Text(title),
                    ),
                  ),
                  if (rightIcon)
                    Icon(
                      Icons.chevron_right,
                      color: colorScheme.onSurfaceVariant,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
