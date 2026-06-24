import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sengthaite_blog/features/portfolio_view.dart';
import 'package:sengthaite_blog/firebase_options.dart';
import 'package:sengthaite_blog/hive_registrar.g.dart';
import 'package:sengthaite_blog/shared/app.data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapters();
  var hivePath = '.hive_data';
  if (!kIsWeb) {
    var directory = await getApplicationCacheDirectory();
    hivePath = "${directory.path}/.hive_data";
  }
  Hive.init(hivePath);
  await AppData().initAppData();

  if (kReleaseMode) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack);
      return true;
    };
  }

  // debugPrintRebuildDirtyWidgets = true;
  // debugPaintSizeEnabled = true;

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => PortfolioView(),
      // builder: (context) => const MainView(),
    ),
  );
}
