import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:sengthaite_blog/constants/portfolio.constants.dart';

PreviewThemeData designSystemPreviewTheme() => PreviewThemeData(
  materialLight: ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF3F3F3F),
      onPrimary: Colors.white,
      secondary: Color(0xFF3F3F3F),
      onSecondary: Colors.white,
      error: Color(0xFF3F3F3F),
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Color(0xFF3F3F3F),
    ),
    radioTheme: RadioThemeData(
      innerRadius: WidgetStatePropertyAll(4.5),
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return radioButtonIconSelectedColor; // Selected fill color
        }
        return radioButtonIconColor; // Unselected fill color
      }),
    ),
  ),
  materialDark: ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.grey[900],
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.white,
      primary: Color(0xFF3F3F3F),
      brightness: Brightness.dark,
      onSurface: Color(0xFF3F3F3F),
    ),
    radioTheme: RadioThemeData(
      innerRadius: WidgetStatePropertyAll(4.5),
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return radioButtonIconSelectedColor; // Selected fill color
        }
        return radioButtonIconColor; // Unselected fill color
      }),
    ),
  ),
);
