// 创建一个 language name provider
// 从 ApiClient /v1/local-languages 获取数据

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/api/client.dart';
import 'package:pokedex/api/models/language.dart';

// 获取语言名称的 provider
final languageNameProvider = FutureProvider.autoDispose<List<LanguageName>>((
  ref,
) async {
  final client = ApiClient();
  final response = await client.get('local-languages');
  final List<dynamic> data = response['data'] as List<dynamic>;
  return data.map((d) => LanguageName.fromJson(d)).toList();
});

// 缓存语言列表
final languageNameMapProvider = Provider<Map<String, String>>((ref) {
  final languagesAsync = ref.watch(languageNameProvider);
  return languagesAsync.when(
    data:
        (languages) => {
          for (var lang in languages) lang.languageId.toString(): lang.name,
        },
    loading: () => const {},
    error: (_, __) => const {},
  );
});
