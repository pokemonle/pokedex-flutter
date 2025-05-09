import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/local_translations.dart';

// 添加一个新的 provider 来专门管理当前语言
final currentLanguageProvider = StateProvider<String>((ref) => 'zh-Hans');

class TranslationNotifier
    extends StateNotifier<Map<String, Map<String, String>>> {
  static const String _baseUrl = "https://locales.pokemonle.com";
  SharedPreferences? _prefs;
  final Map<String, Future<void>> _loadingTranslations = {};
  final Ref ref;

  TranslationNotifier(this.ref) : super({}) {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print('Failed to initialize SharedPreferences: $e');
    }
  }

  String get currentLanguage => ref.read(currentLanguageProvider);

  Future<void> loadTranslation(String ns) async {
    // 如果是 default 命名空间，不需要加载远程翻译
    if (ns == 'default') return;

    final key = '${currentLanguage}$ns';

    // 如果已经加载过，直接返回
    if (state.containsKey(key)) return;

    // 如果正在加载中，等待加载完成
    if (_loadingTranslations.containsKey(key)) {
      await _loadingTranslations[key];
      return;
    }

    // 创建新的加载任务
    final loadingTask = _loadTranslationInternal(ns);
    _loadingTranslations[key] = loadingTask;

    try {
      await loadingTask;
    } finally {
      _loadingTranslations.remove(key);
    }
  }

  Future<void> _loadTranslationInternal(String ns) async {
    try {
      // 尝试从缓存加载
      if (_prefs != null) {
        final cacheKey = 'translation_${currentLanguage}_$ns';
        final cached = _prefs!.getString(cacheKey);
        if (cached != null) {
          state = {
            ...state,
            '${currentLanguage}$ns': Map<String, String>.from(
              json.decode(cached),
            ),
          };
          return;
        }
      }

      // 从网络加载
      final url = Uri.parse('$_baseUrl/${currentLanguage}/$ns.json');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        state = {
          ...state,
          '${currentLanguage}$ns': Map<String, String>.from(data),
        };

        // 保存到缓存
        if (_prefs != null) {
          final cacheKey = 'translation_${currentLanguage}_$ns';
          await _prefs!.setString(cacheKey, response.body);
        }
      }
    } catch (e) {
      print('Error loading translation: $e');
    }
  }

  String t(String ns, String key) {
    // 如果是 default 命名空间，直接返回本地翻译
    if (ns == 'default') {
      return localTranslations[currentLanguage]?['default']?[key] ?? key;
    }
    // 其他命名空间使用远程翻译
    return state['${currentLanguage}$ns']?[key] ?? key;
  }

  Future<void> setLanguage(String language) async {
    if (currentLanguage == language) return;
    ref.read(currentLanguageProvider.notifier).state = language;
    state = Map<String, Map<String, String>>.from(state);
    _loadingTranslations.clear();
  }
}

final translationProvider = StateNotifierProvider<
  TranslationNotifier,
  Map<String, Map<String, String>>
>((ref) {
  return TranslationNotifier(ref);
});

String useTranslation(WidgetRef ref, String ns, String key) {
  final translations = ref.watch(translationProvider);
  final currentLanguage = ref.watch(currentLanguageProvider);

  // 如果是 default 命名空间，直接返回本地翻译
  if (ns == 'default') {
    return localTranslations[currentLanguage]?['default']?[key] ?? key;
  }
  // 其他命名空间使用远程翻译
  return translations['$currentLanguage$ns']?[key] ?? key;
}
