import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 添加一个新的 provider 来专门管理当前语言
final currentLanguageProvider = StateProvider<int>((ref) => 12); // 12 是简体中文的 ID

class TranslationNotifier
    extends StateNotifier<Map<String, Map<String, String>>> {
  final Ref ref;

  TranslationNotifier(this.ref) : super({}) {
    // _initPrefs();
  }

  int get currentLanguage => ref.read(currentLanguageProvider);

  String t(String ns, String key) {
    // 直接返回 key
    return key;
  }

  Future<void> setLanguage(int languageId) async {
    if (currentLanguage == languageId) return;
    ref.read(currentLanguageProvider.notifier).state = languageId;
  }
}

final translationProvider = StateNotifierProvider<
  TranslationNotifier,
  Map<String, Map<String, String>>
>((ref) {
  return TranslationNotifier(ref);
});
