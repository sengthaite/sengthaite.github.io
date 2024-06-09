import 'package:flutter/services.dart';
import 'package:sengthaite_blog/models/app_model.dart';

class AppData {
  static final AppData _appData = AppData._();

  factory AppData() => _appData;

  AppModel? model;

  Future<bool> initData() async {
    if (model != null) return true;
    String content =
        await rootBundle.loadString('assets/autogen_meta/data_content.json');
    model = appModelFromJson(content);
    return true;
  }

  AppData._();
}
