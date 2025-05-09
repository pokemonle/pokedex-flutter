import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/widgets/translation.dart';
import '../../providers/translation.dart';

class LanguageSettingsScreen extends ConsumerWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(currentLanguageProvider);

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

    return Scaffold(
      appBar: AppBar(
        title: const TranslationWidget(
          namespace: 'default',
          textKey: 'Language',
        ),
      ),
      body: ListView(
        children:
            languages.entries.map((entry) {
              final isSelected = currentLanguage == entry.key;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? Theme.of(context).colorScheme.primaryContainer
                          : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    ListTile(
                      title: Center(
                        child: Text(
                          entry.value,
                          style: TextStyle(
                            color:
                                isSelected
                                    ? Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer
                                    : null,
                          ),
                        ),
                      ),
                      onTap:
                          () => ref
                              .read(translationProvider.notifier)
                              .setLanguage(entry.key),
                    ),
                    if (isSelected)
                      Positioned(
                        right: 16,
                        top: 0,
                        bottom: 0,
                        child: Icon(
                          Icons.check,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }
}
