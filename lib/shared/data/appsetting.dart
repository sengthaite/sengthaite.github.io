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
  Locale? locale;

  AppSettings({
    String? id,
    DateTime? createdDate,
    bool? isFullScreenMode,
    Locale? locale,
  }) : id = id ?? const Uuid().v4(),
       createdDate = createdDate ?? DateTime.now(),
       isFullScreenMode = isFullScreenMode ?? false,
       locale = locale ?? Locale('en', 'US');
}
