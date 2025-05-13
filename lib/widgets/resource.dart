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
        type: MaterialType.transparency,
        child: Ink(
          child: InkWell(
            onTap: () async {
              await Future.delayed(Duration(milliseconds: tapDelay));
              onTap?.call();
            },
            child: Padding(
              padding: padding ?? const EdgeInsets.all(2),
              child: Stack(
                children: [
                  if (watermark != null)
                    Positioned.fill(
                      child: Center(
                        child: Transform.rotate(
                          angle: -0.3, // 稍微倾斜一点
                          child: Text(
                            watermark!,
                            style: TextStyle(
                              color:
                                  isSelected
                                      ? colorScheme.primary.withOpacity(0.2)
                                      : colorScheme.primaryContainer,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            title,
                            style: TextStyle(
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                              color: isSelected ? colorScheme.primary : null,
                            ),
                          ),
                          subtitle:
                              subtitle != null
                                  ? Text(
                                    subtitle!,
                                    style: TextStyle(
                                      color:
                                          isSelected
                                              ? colorScheme.primary
                                              : null,
                                    ),
                                  )
                                  : null,
                          leading: icon,
                        ),
                      ),
                      if (rightIcon)
                        Icon(
                          Icons.chevron_right,
                          color:
                              isSelected
                                  ? colorScheme.primary
                                  : colorScheme.onSurfaceVariant,
                        ),
                    ],
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
