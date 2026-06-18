import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/fontsize_ext.dart';

// Menu Button Style

Color buttonTextColor = const Color(0xFF3F3F3F);

Color buttonTextSelectedColor = const Color(0xFFFFFFFF);

Color buttonIconColor = const Color(0xFF3F3F3F);

Color buttonIconSelectedColor = const Color(0xFFFFFFFF);

Color buttonBorderColor = const Color(0xFFC9C8C8);

Color buttonBackgroundColor = const Color(0xFFF1F1F1);

Color buttonBackgroundSelectedColor = const Color(0xCCD40004);

TextStyle menuButtonTitleStyle = TextStyle(
  color: buttonTextColor,
  fontSize: FontSizeExt.appBarTitle.value,
  fontWeight: FontWeight.normal,
);

TextStyle menuButtonTitleSelectedStyle = TextStyle(
  color: buttonTextSelectedColor,
  fontSize: FontSizeExt.appBarTitle.value,
  fontWeight: FontWeight.w600,
);

ButtonStyle menuButtonStyle = IconButton.styleFrom(
  backgroundColor: buttonBackgroundColor,
  side: BorderSide(color: buttonBorderColor, width: 2),
);

ButtonStyle menuButtonSelectedStyle = IconButton.styleFrom(
  backgroundColor: buttonBackgroundSelectedColor,
  side: BorderSide(color: buttonBorderColor, width: 2),
);

// Text Menu Button Style

Color textButtonSelectedColor = const Color(0xFFD40004);

Color textButtonColor = const Color(0xFF3F3F3F);

TextStyle textMenuButtonTitleStyle = TextStyle(
  color: textButtonColor,
  fontSize: FontSizeExt.textMenuButtonTitle.value,
  fontWeight: FontWeight.normal,
);

TextStyle textMenuButtonTitleSelectedStyle = TextStyle(
  color: textButtonSelectedColor,
  fontSize: FontSizeExt.textMenuButtonTitle.value,
  fontWeight: FontWeight.w600,
);

// Profile

Color primaryTextColor = const Color(0xFF3F3F3F);
