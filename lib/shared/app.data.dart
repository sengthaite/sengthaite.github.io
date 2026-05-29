import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive_ce/hive.dart';
import 'package:sengthaite_blog/constants/app.constants.dart';
import 'package:sengthaite_blog/generated/models/app_model.dart';
import 'package:sengthaite_blog/shared/data/appsetting.dart';
import 'package:sengthaite_blog/shared/data/file/hiveeditor.dart';

class AppData {
  static final AppData _appData = AppData._();

  factory AppData() => _appData;

  AppModel? model;

  AppSettings? appSettings;

  HiveEditor? textEditor;

  Future<Box<AppSettings>> get _boxSetting async =>
      await Hive.openBox<AppSettings>(hiveAppSettingsBox);

  Future<Box<HiveEditor>> get _boxEditor async =>
      await Hive.openBox<HiveEditor>(hiveEditorBox);

  Future<void> saveEditorContent() async {
    try {
      if (textEditor == null) {
        debugPrint("textEditor is null");
        return;
      }
      final box = await _boxEditor;
      box.put("editorContent", textEditor!);
      await textEditor?.save();
    } catch (error) {
      debugPrint("Error saving HiveEditor: $error");
    }
  }

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  void saveAppSettings() async {
    try {
      if (appSettings == null) {
        debugPrint("AppSettings is null");
        return;
      }
      var box = await _boxSetting;
      box.put('appSettings', appSettings!);
      await appSettings?.save();
    } catch (error) {
      debugPrint("Error saving AppSettings: $error");
    }
  }

  Future<bool> initTextEditorData() async {
    textEditor ??= (await _boxEditor).get('editorContent') ?? HiveEditor();
    return true;
  }

  Future<bool> initAppData() async {
    if (model == null) {
      String content = await rootBundle.loadString(
        'assets/autogen_meta/data_content.json',
      );
      model = appModelFromJson(content);
    }
    appSettings ??= (await _boxSetting).get('appSettings') ?? AppSettings();
    return true;
  }

  AppData._();
}
