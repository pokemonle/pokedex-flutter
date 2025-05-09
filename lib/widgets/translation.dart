import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/translation.dart';
import '../constants/local_translations.dart';

/// 全局翻译函数，可以在没有 ref 的地方使用
String t(String namespace, String textKey) {
  final container = ProviderContainer();
  final currentLanguage = container.read(currentLanguageProvider);

  // 如果是 default 命名空间，直接返回本地翻译
  if (namespace == 'default') {
    return localTranslations[currentLanguage]?['default']?[textKey] ?? textKey;
  }

  // 其他命名空间使用远程翻译
  final translations = container.read(translationProvider);
  return translations['$currentLanguage$namespace']?[textKey] ?? textKey;
}

/// 获取翻译后的字符串（需要 WidgetRef）
String useTranslationString(WidgetRef ref, String namespace, String textKey) {
  // Auto load translation when used
  Future.microtask(
    () => ref.read(translationProvider.notifier).loadTranslation(namespace),
  );
  return useTranslation(ref, namespace, textKey);
}

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
