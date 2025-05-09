import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/translation.dart';

class TranslationWidget extends ConsumerWidget {
  final String namespace;
  final String textKey;
  final TextStyle? style;

  const TranslationWidget({
    super.key,
    required this.namespace,
    required this.textKey,
    this.style,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Auto load translation when used
    Future.microtask(
      () => ref.read(translationProvider.notifier).loadTranslation(namespace),
    );

    return Text(useTranslation(ref, namespace, textKey), style: style);
  }
}
