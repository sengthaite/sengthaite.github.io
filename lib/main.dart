import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sengthaite_blog/components/main_view.dart';
import 'package:sengthaite_blog/firebase_options.dart';
import 'package:sengthaite_blog/hive_registrar.g.dart';
import 'package:sengthaite_blog/shared/app.data.dart';

void main() async {
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint("Uncaught error: $error");
    debugPrint("Stack trace: $stack");
    return true;
  };

  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapters();
  var hivePath = '.hive_data';
  if (!kIsWeb) {
    var directory = await getApplicationCacheDirectory();
    hivePath = "${directory.path}/.hive_data";
  }
  Hive.init(hivePath);
  await AppData().initData();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MainView(),
    ),
  );
}
