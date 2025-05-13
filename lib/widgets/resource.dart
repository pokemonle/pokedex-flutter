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
  final String? watermark;
  final bool isSelected;

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
    this.watermark,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin:
          margin ?? const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: isSelected ? colorScheme.primaryContainer : colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap:
              onTap == null
                  ? null
                  : () async {
                    await Future.delayed(Duration(milliseconds: tapDelay));
                    if (onTap != null) onTap!();
                  },
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (icon != null && !rightIcon) ...[
                  icon!,
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? colorScheme.primary : null,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: isSelected ? colorScheme.primary : null,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (watermark != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? colorScheme.primary
                              : colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      watermark!,
                      style: TextStyle(
                        fontSize: 12,
                        color:
                            isSelected
                                ? colorScheme.onPrimary
                                : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                if (icon != null && rightIcon) ...[
                  const SizedBox(width: 16),
                  icon!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
