import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sengthaite_blog/extensions/fontsize_ext.dart';

Color textColor = const Color(0xFF3F3F3F);
Color backgroundColor = const Color(0xFFF1F1F1);
Color onBackgroundColor = const Color(0xFFFFFFFF);
Color borderColor = const Color(0xFFC9C8C8);
Color starColor = const Color(0xFFF1B100);
TextStyle textStyle = GoogleFonts.inter().copyWith(
  color: textColor,
  fontSize: FontSize.medium.value,
  fontWeight: FontWeight.w600,
);

// Menu Button Style

Color buttonTextColor = const Color(0xFF3F3F3F);

Color buttonTextSelectedColor = const Color(0xFFFFFFFF);

Color buttonIconColor = const Color(0xFF3F3F3F);

Color buttonIconSelectedColor = const Color(0xFFFFFFFF);

Color buttonBorderColor = borderColor;

Color buttonBackgroundColor = const Color(0xFFF1F1F1);

Color buttonBackgroundSelectedColor = const Color(0xCCD40004);

TextStyle menuButtonTitleStyle = GoogleFonts.inter().copyWith(
  color: buttonTextColor,
  fontSize: FontSizeExt.appBarTitle.value,
  fontWeight: FontWeight.normal,
);

TextStyle menuButtonTitleSelectedStyle = GoogleFonts.inter().copyWith(
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

TextStyle textMenuButtonTitleStyle = GoogleFonts.inter().copyWith(
  color: textButtonColor,
  fontSize: FontSizeExt.textMenuButtonTitle.value,
  fontWeight: FontWeight.normal,
);

TextStyle textMenuButtonTitleSelectedStyle = GoogleFonts.inter().copyWith(
  color: textButtonSelectedColor,
  fontSize: FontSizeExt.textMenuButtonTitle.value,
  fontWeight: FontWeight.w700,
);

// Profile

Color primaryTextColor = const Color(0xFF3F3F3F);

// Side Key Insight
Color sideKeyBackgroundColor = const Color(0xFFE8E8E8);

ButtonStyle sideKeyStyle = IconButton.styleFrom(
  backgroundColor: sideKeyBackgroundColor,
  side: BorderSide(color: buttonBorderColor, width: 2),
);

TextStyle sideKeyTitleStyle = GoogleFonts.inter().copyWith(
  color: buttonTextColor,
  fontSize: FontSizeExt.sideKeyTitle.value,
  fontWeight: FontWeight.w700,
);

// Radio button

Color radioButtonIconColor = Color(0xFFE8E8E8);

Color radioButtonIconSelectedColor = buttonBackgroundSelectedColor;

TextStyle radioButtonTitleStyle = textMenuButtonTitleStyle.copyWith(
  fontWeight: FontWeight.w600,
);

// Pop up

Color popUpBackgroundColor = sideKeyBackgroundColor;

Color popUpBorderColor = buttonBorderColor;

Color popUpDividerColor = Colors.white;

TextStyle popUpTitleStyle = GoogleFonts.inter().copyWith(
  fontSize: 18,
  fontWeight: FontWeight.w800,
  color: textButtonColor,
);

// Lef side icon

Color leftSideIconSkills = Color(0xFF323232);
