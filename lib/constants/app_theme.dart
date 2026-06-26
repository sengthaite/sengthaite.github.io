import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sengthaite_blog/constants/portfolio_theme.dart';
import 'package:sengthaite_blog/extensions/style_ext.dart';

class AppTheme {
  AppTheme._();

  // Custom visual constants matching "Launch screen.png"
  static const Color _lightPrimaryRed = Color(0xFFD32F2F);
  static const Color _lightSurfaceContainer = Color(0xFFEFEFEF);
  static const Color _lightTextDark = Color(0xFF2A2A2A);

  /// ==========================================
  /// 1. STANDARD THEMES
  /// ==========================================

  /// Tailored exactly to "Launch screen.png" Light Mode
  static ThemeData get lightTheme => _baseTheme(
    brightness: Brightness.light,
    scheme: const ColorScheme.light(
      // Button selected color
      primary: _lightPrimaryRed,
      onPrimary: Colors.white,
      // Button default background color
      secondary: Color(0xFFF1F1F1),
      onSecondary: Colors.white,
      surface: Color(0xFFF1F1F1),
      onSurface: _lightTextDark,
      surfaceContainer: _lightSurfaceContainer,
      // Border color
      outline: Color(0xFFC9C8C8),
    ),
    extensions: [
      PortfolioTheme(
        textStyle: GoogleFonts.notoSansKhmer()
            .copyWith(fontSize: 16, color: Color(0xFF3F3F3F))
            .medium!,
        selectedTextStyle: GoogleFonts.notoSansKhmer()
            .copyWith(fontSize: 16, color: Colors.white)
            .bold!,
        buttonBgColor: Color(0xFFF1F1F1),
        buttonSelectedBgColor: _lightPrimaryRed,
        buttonFgColor: Color(0xFF3F3F3F),
        buttonSelectedFgColor: Colors.white,
        dialogBgColor: Color(0xFFE8E8E8),
        borderColor: Color(0xFFC9C8C8),
        containerBgColor: Color(0xFFF1F1F1),
        dividerColor: Color(0xFFC9C8C8),
        scaffoldBgColor: Colors.white,
      ),
    ],
  );

  /// Inverted Dark Mode counterpart matching the same design rules
  static ThemeData get darkTheme => _baseTheme(
    brightness: Brightness.dark,
    scheme: const ColorScheme.dark(
      primary: Color(
        0xFFFF5252,
      ), // Slightly brighter red for dark mode readability
      onPrimary: Color.fromARGB(255, 44, 44, 44),
      secondary: Color(0xB3FFFFFF),
      onSecondary: Colors.black,
      surface: Color(0xFFF1F1F1), // Dark deep gray scaffold
      onSurface: Color(0xFFE0E0E0), // Clean light text
      surfaceContainer: Color(0xFF1E1E1E), // Subtle dark card background
      outline: Color(0xFF444444),
    ),
    extensions: [
      PortfolioTheme(
        textStyle: GoogleFonts.notoSansKhmer()
            .copyWith(fontSize: 16, color: Color.fromARGB(255, 255, 255, 255))
            .medium!,
        selectedTextStyle: GoogleFonts.notoSansKhmer()
            .copyWith(fontSize: 16, color: Colors.white)
            .bold!,
        buttonBgColor: Color.fromARGB(255, 72, 72, 72),
        buttonSelectedBgColor: _lightPrimaryRed,
        buttonFgColor: Color.fromARGB(255, 255, 255, 255),
        buttonSelectedFgColor: Colors.white,
        dialogBgColor: Color.fromARGB(255, 68, 68, 68),
        borderColor: Color(0xFFC9C8C8),
        containerBgColor: Color.fromARGB(255, 66, 66, 66),
        dividerColor: Color(0xFFC9C8C8),
        scaffoldBgColor: Colors.white,
      ),
    ],
  );

  /// ==========================================
  /// 2. HIGH CONTRAST THEMES
  /// ==========================================

  static ThemeData get highContrastLightTheme => _baseTheme(
    brightness: Brightness.light,
    isHighContrast: true,
    scheme: const ColorScheme.light(
      primary: Color(0xFFB71C1C), // Deep highly legible red
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
      surfaceContainer: Color(0xFFE0E0E0),
      outline: Colors.black,
    ),
    extensions: lightTheme.extensions.values,
  );

  static ThemeData get highContrastDarkTheme => _baseTheme(
    brightness: Brightness.dark,
    isHighContrast: true,
    scheme: const ColorScheme.dark(
      primary: Color(0xFFFF8A80), // Maximum contrast neon red
      onPrimary: Colors.black,
      surface: Colors.black, // Pure OLED black
      onSurface: Colors.white,
      surfaceContainer: Color(0xFF121212),
      outline: Colors.white,
    ),
    extensions: darkTheme.extensions.values,
  );

  /// ==========================================
  /// 3. BASE THEME BUILDER
  /// ==========================================
  static ThemeData _baseTheme({
    required Brightness brightness,
    required ColorScheme scheme,
    Iterable<ThemeExtension<dynamic>>? extensions,
    bool isHighContrast = false,
  }) {
    final bool isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,

      extensions: extensions,

      // Match the soft capsule styling of the buttons and dropdowns
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
      ),

      // Tab bar matching the [EXPERIENCE] / [EDUCATION] styling rules
      tabBarTheme: TabBarThemeData(
        labelColor: scheme.primary,
        unselectedLabelColor: isDark ? Colors.white60 : Colors.black54,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: scheme.primary, width: 3),
        ),
      ),

      // Simulating the capsule button design (e.g. SETTINGS pill)
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: StadiumBorder(
            side: isHighContrast
                ? BorderSide(color: scheme.outline, width: 2.5)
                : BorderSide.none,
          ),
        ),
      ),

      // Card implementation matching the rounded info-box profiles
      cardTheme: CardThemeData(
        color: scheme.surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: scheme.outline,
            width: isHighContrast ? 2.5 : 1.0,
          ),
        ),
      ),

      // Text configurations mapped out from the layout hierarchy
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.notoSansKhmer().copyWith(
          fontSize: 28,
          fontWeight: isHighContrast ? FontWeight.w500 : FontWeight.bold,
          color: scheme.onSurface,
          letterSpacing: 0.5,
        ),
        titleMedium: GoogleFonts.notoSansKhmer().copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: scheme.onSurface,
        ),
        bodyLarge: GoogleFonts.notoSansKhmer().copyWith(
          fontSize: 14,
          height: 1.5,
          color: scheme.onSurface,
          fontWeight: isHighContrast ? FontWeight.w600 : FontWeight.normal,
        ),
      ),

      dividerTheme: DividerThemeData(color: scheme.outline),
    );
  }
}
