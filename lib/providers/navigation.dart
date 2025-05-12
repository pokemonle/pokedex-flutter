import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/api/models/resource.dart';
import 'package:pokedex/screens/resource.dart';
import 'package:pokedex/screens/resource_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigationModeProvider =
    StateNotifierProvider<NavigationModeNotifier, bool>((ref) {
      return NavigationModeNotifier();
    });

class NavigationModeNotifier extends StateNotifier<bool> {
  NavigationModeNotifier() : super(kIsWeb) {
    _init();
  }

  static const String _key = 'use_side_navigation';
  SharedPreferences? _prefs;

  Future<void> _init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      state = _prefs?.getBool(_key) ?? kIsWeb;
    } catch (e) {
      // 如果初始化失败，使用默认值
      state = kIsWeb;
    }
  }

  Future<void> setNavigationMode(bool useSideNavigation) async {
    try {
      _prefs ??= await SharedPreferences.getInstance();
      await _prefs?.setBool(_key, useSideNavigation);
      state = useSideNavigation;
    } catch (e) {
      // 如果保存失败，仍然更新状态
      state = useSideNavigation;
    }
  }
}

typedef ResourceScreenBuilder<T extends LanguageResource> =
    Widget Function(
      BuildContext context,
      String resourceType,
      int resourceId,
      String title,
      T Function(Map<String, dynamic> json) fromJsonFactory,
    );

void navigateToResource<T extends LanguageResource>(
  BuildContext context,
  String resourceType,
  int resourceId,
  String title,
  T Function(Map<String, dynamic>) fromJsonFactory,
  ResourceScreenBuilder<T> resourceScreenBuilder,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder:
          (context) => resourceScreenBuilder(
            context,

            resourceType,
            resourceId,
            title,
            fromJsonFactory,
          ),
    ),
  );
}

void navigateToResourceList<T extends LanguageResource>(
  BuildContext context,
  String resourceType,
  String title,
  T Function(Map<String, dynamic>) fromJsonFactory,
  ResourceScreenBuilder<T> resourceScreenBuilder,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder:
          (context) => ResourceListScreen<T>(
            resourceType: resourceType,
            title: title,
            fromJsonFactory: fromJsonFactory,
            resourceScreenBuilder: resourceScreenBuilder,
          ),
    ),
  );
}
