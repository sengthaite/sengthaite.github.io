import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/portfolio/portfolio_theme.dart';
import 'package:sengthaite_blog/l10n/app_localizations.dart';

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  PortfolioTheme get pfTheme => theme.extension<PortfolioTheme>()!;

  Orientation get orientation => MediaQuery.orientationOf(this);

  AppLocalizations get l10n => AppLocalizations.of(this)!;

  Size get screenSize => MediaQuery.sizeOf(this);

  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);
}
