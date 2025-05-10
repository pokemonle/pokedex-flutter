import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/providers/font.dart';
import '../providers/translation.dart';
import '../providers/navigation.dart';
import '../providers/language.dart';
import 'settings/language.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(currentLanguageProvider);
    final useSideNavigation = ref.watch(navigationModeProvider);
    final usePixelFont = ref.watch(pixelFontProvider);
    final languageNames = ref.watch(languageNameMapProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(AppLocalizations.of(context)!.language),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  languageNames[currentLanguage.toString()] ??
                      currentLanguage.toString(),
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
            title: Text(AppLocalizations.of(context)!.useSideNavigation),

            value: useSideNavigation,
            onChanged: (bool value) {
              ref
                  .read(navigationModeProvider.notifier)
                  .setNavigationMode(value);
            },
          ),
          SwitchListTile.adaptive(
            secondary: const Icon(Icons.view_sidebar),
            title: Text(AppLocalizations.of(context)!.usePixelFont),
            value: usePixelFont,
            onChanged: (bool value) {
              ref.read(pixelFontProvider.notifier).setPixelFont(value);
            },
          ),
        ],
      ),
    );
  }
}
