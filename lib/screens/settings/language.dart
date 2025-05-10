import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/translation.dart';
import '../../providers/language.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final languageMap = {
  1: const Locale('ja'), // 日语
  3: const Locale('ko'), // 韩语
  5: const Locale('fr'), // 法语
  6: const Locale('de'), // 德语
  7: const Locale('es'), // 西班牙语
  9: const Locale('en'), // 英语
  12: const Locale('zh', 'Hans'), // 简体中文
};

class LanguageSettingsScreen extends ConsumerWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(currentLanguageProvider);
    final languagesAsync = ref.watch(languageNameProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.language)),
      body: languagesAsync.when(
        data:
            (languages) => ListView(
              children:
                  languages.map((language) {
                    final isSelected = currentLanguage == language.languageId;
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
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
                                language.name,
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
                                    .setLanguage(language.languageId),
                          ),
                          if (isSelected)
                            Positioned(
                              right: 16,
                              top: 0,
                              bottom: 0,
                              child: Icon(
                                Icons.check,
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
