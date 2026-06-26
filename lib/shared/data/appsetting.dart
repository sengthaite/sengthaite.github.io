import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:uuid/uuid.dart';

part 'appsetting.g.dart';

@HiveType(typeId: 3)
class AppSettings extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final DateTime createdDate;
  @HiveField(2)
  bool isFullScreenMode;
  @HiveField(3)
  String? localeLanguageCode;
  @HiveField(4)
  String? githubToken;
  @HiveField(5)
  String? githubUrl;
  @HiveField(6)
  bool? rememberedMe;
  @HiveField(7)
  String? themeMode;

  ValueNotifier<Locale> currentLocale = ValueNotifier(const Locale('en'));
  ValueNotifier<ThemeMode> currentThemeMode = ValueNotifier(ThemeMode.system);

  set locale(Locale? value) {
    localeLanguageCode = value?.languageCode;
    currentLocale.value = value ?? const Locale('en');
  }

  set newThemeMode(ThemeMode? mode) {
    debugPrint("New ThemeMode: ${mode?.name}");
    themeMode = mode?.name;
    if (mode == null) return;
    currentThemeMode.value = mode;
  }

  ThemeMode get _themeModeFromCache {
    switch (themeMode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
    }
    return ThemeMode.system;
  }

  bool get isRememberedMe => rememberedMe ?? false;

  AppSettings({
    String? id,
    DateTime? createdDate,
    bool? isFullScreenMode,
    Locale? locale,
    ThemeMode? theme,
  }) : id = id ?? const Uuid().v4(),
       createdDate = createdDate ?? DateTime.now(),
       isFullScreenMode = isFullScreenMode ?? false,
       localeLanguageCode = locale?.languageCode {
    currentLocale.value = locale ?? Locale(localeLanguageCode ?? 'en');
    currentThemeMode.value = theme ?? _themeModeFromCache;
  }
}
