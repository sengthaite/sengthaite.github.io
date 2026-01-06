import 'dart:ui';

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
  String? localeCountryCode;

  set locale(Locale? value) {
    localeLanguageCode = value?.languageCode;
    localeCountryCode = value?.countryCode;
  }

  Locale? get locale {
    if (localeLanguageCode == null) return null;
    return Locale(localeLanguageCode!, localeCountryCode);
  }

  AppSettings({
    String? id,
    DateTime? createdDate,
    bool? isFullScreenMode,
    Locale? locale,
  }) : id = id ?? const Uuid().v4(),
       createdDate = createdDate ?? DateTime.now(),
       isFullScreenMode = isFullScreenMode ?? false,
       localeLanguageCode = locale?.languageCode,
       localeCountryCode = locale?.countryCode;
}
