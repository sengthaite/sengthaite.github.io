import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

PreviewThemeData designSystemPreviewTheme() => PreviewThemeData(
  materialLight: ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorSchemeSeed: Colors.blue,
  ),
  materialDark: ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorSchemeSeed: Colors.deepPurple,
  ),
);
