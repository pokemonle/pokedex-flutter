import 'package:flutter/material.dart';

class ResourceWidget extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget? icon;
  final bool rightIcon;
  final VoidCallback? onTap;
  final int tapDelay;
  final String title;
  final String? subtitle;
  const ResourceWidget({
    super.key,
    this.margin,
    this.padding,
    this.icon,
    this.rightIcon = false,
    this.onTap,
    this.tapDelay = 150,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin:
          margin ?? const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
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
              padding: padding ?? const EdgeInsets.all(2),
              child: Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(title),
                      subtitle: subtitle != null ? Text(subtitle!) : null,
                      leading: icon,
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
