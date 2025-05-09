import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/translation.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final translations = ref.watch(translationProvider);
    final currentLanguage =
        ref.read(translationProvider.notifier).currentLanguage;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('English'),
            trailing: currentLanguage == 'en' ? const Icon(Icons.check) : null,
            onTap:
                () => ref.read(translationProvider.notifier).setLanguage('en'),
          ),
          ListTile(
            title: const Text('简体中文'),
            trailing:
                currentLanguage == 'zh-Hans' ? const Icon(Icons.check) : null,
            onTap:
                () => ref
                    .read(translationProvider.notifier)
                    .setLanguage('zh-Hans'),
          ),
          // 其他语言选项...
        ],
      ),
    );
  }
}
