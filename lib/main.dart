import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sengthaite_blog/hive_registrar.g.dart';
import 'package:sengthaite_blog/main_portfolio.dart';
import 'package:sengthaite_blog/shared/app.data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapters();
  var hivePath = '.hive_data';
  if (!kIsWeb) {
    // TODO: Debug and fix exception when running on mobile device, currently only works on web and desktop
    // TODO: reimplement firebase
    var directory = await getApplicationDocumentsDirectory();
    var hiveDir = Directory("${directory.path}/.hive_data");
    if (!await hiveDir.exists()) {
      await hiveDir.create(recursive: true);
    }

    hivePath = hiveDir.path;
  }
  Hive.init(hivePath);
  await AppData().initAppData();

  final bool enablePreveiw = false;
  // debugPrintRebuildDirtyWidgets = true;
  // debugPaintSizeEnabled = true;

  runApp(
    DevicePreview(
      enabled: kDebugMode && enablePreveiw,
      builder: (context) => MainPortfolioView(),
      // builder: (context) => const MainView(),
    ),
  );
}
