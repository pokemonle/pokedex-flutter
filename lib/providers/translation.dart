import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TranslationNotifier
    extends StateNotifier<Map<String, Map<String, String>>> {
  String _currentLanguage = 'zh-Hans';
  static const String _baseUrl = "https://locales.pokemonle.com";
  SharedPreferences? _prefs;
  final Map<String, Future<void>> _loadingTranslations = {};

  TranslationNotifier() : super({}) {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print('Failed to initialize SharedPreferences: $e');
    }
  }

  String get currentLanguage => _currentLanguage;

  Future<void> loadTranslation(String ns) async {
    final key = '$_currentLanguage$ns';

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
        final cacheKey = 'translation_${_currentLanguage}_$ns';
        final cached = _prefs!.getString(cacheKey);
        if (cached != null) {
          state = {
            ...state,
            '$_currentLanguage$ns': Map<String, String>.from(
              json.decode(cached),
            ),
          };
          return;
        }
      }

      // 从网络加载
      final url = Uri.parse('$_baseUrl/$_currentLanguage/$ns.json');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        state = {
          ...state,
          '$_currentLanguage$ns': Map<String, String>.from(data),
        };

        // 保存到缓存
        if (_prefs != null) {
          final cacheKey = 'translation_${_currentLanguage}_$ns';
          await _prefs!.setString(cacheKey, response.body);
        }
      }
    } catch (e) {
      print('Error loading translation: $e');
    }
  }

  String t(String ns, String key) {
    return state['$_currentLanguage$ns']?[key] ?? key;
  }

  Future<void> setLanguage(String language) async {
    if (_currentLanguage == language) return;
    _currentLanguage = language;
    state = {};
    _loadingTranslations.clear();
  }
}

final translationProvider = StateNotifierProvider<
  TranslationNotifier,
  Map<String, Map<String, String>>
>((ref) {
  return TranslationNotifier();
});

String useTranslation(WidgetRef ref, String ns, String key) {
  final translations = ref.watch(translationProvider);
  final currentLanguage =
      ref.read(translationProvider.notifier)._currentLanguage;
  return translations['$currentLanguage$ns']?[key] ?? key;
}
