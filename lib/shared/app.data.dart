import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive_ce/hive.dart';
import 'package:sengthaite_blog/constants/app.constants.dart';
import 'package:sengthaite_blog/generated/models/app_model.dart';
import 'package:sengthaite_blog/shared/data/appsetting.dart';

class AppData {
  static final AppData _appData = AppData._();

  factory AppData() => _appData;

  AppModel? model;

  AppSettings? appSettings;

  Future<Box<AppSettings>> get _box async =>
      await Hive.openBox<AppSettings>(hiveAppSettings);

  void saveAppSettings() async {
    if (appSettings == null) {
      debugPrint("AppSettings is null");
      return;
    }
    var box = await _box;
    box.put('appSettings', appSettings!);
    await appSettings?.save();
  }

  Future<bool> initData() async {
    if (model == null) {
      String content = await rootBundle.loadString(
        'assets/autogen_meta/data_content.json',
      );
      model = appModelFromJson(content);
    }
    if (appSettings == null) {
      var box = await _box;
      appSettings = box.get('appSettings') ?? AppSettings();
    }
    return true;
  }

  AppData._();
}
