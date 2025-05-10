// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/providers/font.dart';
import 'package:pokedex/providers/navigation.dart';
import 'package:pokedex/providers/translation.dart';
import 'package:pokedex/screens/home.dart';
import 'package:pokedex/screens/settings.dart';
import 'package:pokedex/screens/settings/language.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLanguage = ref.watch(currentLanguageProvider);
    final locale = languageMap[currentLanguage] ?? const Locale('en');

    return MaterialApp(
      title: 'Pokedex Flutter App',
      locale: locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale.fromSubtags(languageCode: 'en'),
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
        Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
        Locale.fromSubtags(languageCode: 'es'),
        Locale.fromSubtags(languageCode: 'fr'),
        Locale.fromSubtags(languageCode: 'de'),
        Locale.fromSubtags(languageCode: 'it'),
        Locale.fromSubtags(languageCode: 'ja'),
        Locale.fromSubtags(languageCode: 'ko'),
        Locale.fromSubtags(languageCode: 'cs'),
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
          surface: Colors.white,
          onSurface: Colors.black,
          surfaceContainer: Colors.grey[100],
        ),
        shadowColor: Colors.transparent,
        cardTheme: const CardTheme(elevation: 0),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(elevation: 0),
        ),

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: ref.watch(pixelFontProvider) ? 'fusion' : null,
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system, // Or ThemeMode.light, ThemeMode.dark
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends ConsumerStatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  ConsumerState<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[HomeScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    final useSideNavigation = ref.watch(navigationModeProvider);

    if (useSideNavigation) {
      return Scaffold(
        body: Row(
          children: <Widget>[
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.selected,
              leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.catching_pokemon,
                      size: 40,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Theme.of(context).colorScheme.primary,
                    ),
                    Text(
                      'Pokedex',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              destinations: <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: Text(AppLocalizations.of(context)!.home),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings_outlined),
                  selectedIcon: Icon(Icons.settings),
                  label: Text(AppLocalizations.of(context)!.settings),
                ),
              ],
              selectedIconTheme: IconThemeData(
                color: Theme.of(context).colorScheme.primary,
              ),
              selectedLabelTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              elevation: 4,
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: _screens[_selectedIndex]),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: AppLocalizations.of(context)!.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              activeIcon: Icon(Icons.settings),
              label: AppLocalizations.of(context)!.settings,
            ),
          ],
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(
            context,
          ).colorScheme.onSurface.withAlpha(128),
        ),
      );
    }
  }
}
