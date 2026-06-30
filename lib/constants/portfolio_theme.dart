import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/style_ext.dart';

class PortfolioTheme extends ThemeExtension<PortfolioTheme> {
  // Text Theme
  final TextStyle textStyle; // Profressional summary text, Contact buttons
  final TextStyle selectedTextStyle;

  TextStyle? get titleTextStyle =>
      textStyle.copyWith(fontSize: 40).bold; // Name
  TextStyle? get subtitleTextStyle =>
      textStyle.copyWith(fontSize: 18); // Leadership
  TextStyle? get dialogRadioTitleTextStyle =>
      subtitleTextStyle.bold; // Leadership style
  TextStyle? get menuTextStyle => textStyle.copyWith(fontSize: 20);
  TextStyle? get menuSelectedTextStyle =>
      selectedTextStyle.copyWith(fontSize: 20).bold;
  TextStyle? get contentTabTextStyle => textStyle.copyWith(fontSize: 16);
  TextStyle? get contentTabSelectedTextStyle =>
      selectedTextStyle.copyWith(fontSize: 16).bold;
  TextStyle? get roleTitleTextStyle => textStyle.copyWith(fontSize: 24).bold;
  TextStyle? get roleDetailTextStyle =>
      roleTitleTextStyle?.copyWith(fontSize: 18);
  TextStyle? get ActivityMainInformationTextStyle =>
      textStyle.copyWith(fontSize: 20, color: buttonFgColor).bold;
  TextStyle? get ActivityMainInformationSelectedTextStyle =>
      selectedTextStyle.copyWith(fontSize: 20, color: buttonSelectedBgColor);
  TextStyle? get dialogTitleTextStyle => ActivityMainInformationTextStyle;
  TextStyle? get skillsTextStyle => textStyle.copyWith(fontSize: 16);
  TextStyle? get sideMenuTitleStyle => textStyle.copyWith(fontSize: 14);
  TextStyle? get sectionTitleStyle =>
      textStyle.copyWith(fontSize: 16).bold; // Skills and footer title style
  TextStyle? get feedbackTitleStyle => textStyle.copyWith(fontSize: 36).bold;
  TextStyle? get feedbackSubTitleStyle => textStyle.copyWith(fontSize: 16);
  TextStyle? get feedbackInputStyle => feedbackSubTitleStyle;

  ButtonStyle get buttonStyle => IconButton.styleFrom(
    backgroundColor: buttonBgColor,
    side: BorderSide(color: borderColor, width: 2),
  );

  ButtonStyle get buttonSelectedStyle => IconButton.styleFrom(
    backgroundColor: buttonSelectedBgColor,
    side: BorderSide(color: borderColor, width: 2),
  );

  BoxBorder get border => Border.all(color: borderColor, width: 1);

  BoxBorder get borderBold => Border.all(color: borderColor, width: 2);

  final Size sectionIconSize = Size(16, 16);

  // Color Theme
  final Color buttonBgColor;
  final Color buttonSelectedBgColor;
  final Color buttonFgColor;
  final Color buttonSelectedFgColor;

  // Dialog Theme
  final Color dialogBgColor;

  // Other Color Theme
  final Color borderColor;
  final Color containerBgColor; // Professional summary color
  final Color dividerColor;
  final Color scaffoldBgColor;
  final Color starColor = Color(0xFFF1B100);

  PortfolioTheme({
    required this.textStyle,
    required this.selectedTextStyle,
    required this.buttonBgColor,
    required this.buttonSelectedBgColor,
    required this.buttonFgColor,
    required this.buttonSelectedFgColor,
    required this.dialogBgColor,
    required this.borderColor,
    required this.containerBgColor,
    required this.dividerColor,
    required this.scaffoldBgColor,
  }); // Pop up divider color

  @override
  ThemeExtension<PortfolioTheme> copyWith({
    TextStyle? textStyle,
    TextStyle? selectedTextStyle,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    TextStyle? menuTextStyle,
    TextStyle? contentTabTextStyle,
    TextStyle? contentTabSelectedTextStyle,
    TextStyle? roleTitleTextStyle,
    TextStyle? sideMenuTitleStyle,
    TextStyle? sectionTitleStyle,
    Size? sectionIconSize,
    Color? buttonBgColor,
    Color? buttonSelectedBgColor,
    Color? buttonFgColor,
    Color? buttonSelectedFgColor,
    Color? dialogBgColor,
    Color? borderColor,
    Color? containerBgColor,
    Color? dividerColor,
    Color? scaffoldBgColor,
  }) {
    return PortfolioTheme(
      selectedTextStyle: selectedTextStyle ?? this.selectedTextStyle,
      textStyle: textStyle ?? this.textStyle,
      buttonBgColor: buttonBgColor ?? this.buttonBgColor,
      buttonSelectedBgColor:
          buttonSelectedBgColor ?? this.buttonSelectedBgColor,
      buttonFgColor: buttonFgColor ?? this.buttonFgColor,
      buttonSelectedFgColor:
          buttonSelectedFgColor ?? this.buttonSelectedFgColor,
      dialogBgColor: dialogBgColor ?? this.dialogBgColor,
      borderColor: borderColor ?? this.borderColor,
      containerBgColor: containerBgColor ?? this.containerBgColor,
      dividerColor: dividerColor ?? this.dividerColor,
      scaffoldBgColor: scaffoldBgColor ?? this.scaffoldBgColor,
    );
  }

  @override
  ThemeExtension<PortfolioTheme> lerp(
    covariant ThemeExtension<PortfolioTheme>? other,
    double t,
  ) {
    if (other is! PortfolioTheme) return this;
    return PortfolioTheme(
      textStyle: textStyle,
      selectedTextStyle: selectedTextStyle,
      buttonBgColor: Color.lerp(buttonBgColor, other.buttonBgColor, t)!,
      buttonSelectedBgColor: Color.lerp(
        buttonSelectedBgColor,
        other.buttonSelectedBgColor,
        t,
      )!,
      buttonFgColor: Color.lerp(buttonFgColor, other.buttonFgColor, t)!,
      buttonSelectedFgColor: Color.lerp(
        buttonSelectedFgColor,
        other.buttonSelectedFgColor,
        t,
      )!,
      dialogBgColor: Color.lerp(dialogBgColor, other.dialogBgColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      containerBgColor: Color.lerp(
        containerBgColor,
        other.containerBgColor,
        t,
      )!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
      scaffoldBgColor: Color.lerp(scaffoldBgColor, other.scaffoldBgColor, t)!,
    );
  }
}
