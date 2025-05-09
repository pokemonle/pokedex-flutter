import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/providers/font.dart';
import 'package:pokedex/widgets/translation.dart';
import '../providers/translation.dart';
import '../providers/navigation.dart';
import 'settings/language.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(currentLanguageProvider);
    final useSideNavigation = ref.watch(navigationModeProvider);
    final usePixelFont = ref.watch(pixelFontProvider);

    return Scaffold(
      appBar: AppBar(
        title: const TranslationWidget(
          namespace: 'default',
          textKey: 'Settings',
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: const TranslationWidget(
              namespace: 'default',
              textKey: 'Language',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _getLanguageName(currentLanguage),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(128),
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LanguageSettingsScreen(),
                  ),
                ),
          ),
          SwitchListTile.adaptive(
            secondary: const Icon(Icons.view_sidebar),
            title: const TranslationWidget(
              namespace: 'default',
              textKey: 'Use Side Navigation',
            ),
            subtitle: const TranslationWidget(
              namespace: 'default',
              textKey: 'Use Side Navigation Description',
            ),
            value: useSideNavigation,
            onChanged: (bool value) {
              ref
                  .read(navigationModeProvider.notifier)
                  .setNavigationMode(value);
            },
          ),
          SwitchListTile.adaptive(
            secondary: const Icon(Icons.view_sidebar),
            title: const TranslationWidget(
              namespace: 'default',
              textKey: 'Use Pixel Font',
            ),
            value: usePixelFont,
            onChanged: (bool value) {
              ref.read(pixelFontProvider.notifier).setPixelFont(value);
            },
          ),
        ],
      ),
    );
  }

  String _getLanguageName(String code) {
    final languages = {
      'en': 'English',
      'zh-Hans': '简体中文',
      'zh-Hant': '繁體中文',
      'ja': '日本語',
      'kr': '한국어',
      'fr': 'Français',
      'de': 'Deutsch',
      'es': 'Español',
      'it': 'Italiano',
      'cs': 'Čeština',
    };
    return languages[code] ?? code;
  }
}
