import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/portfolio_theme.dart';
import 'package:sengthaite_blog/l10n/app_localizations.dart';
import 'package:sengthaite_blog/shared/app.data.dart';
import 'package:sengthaite_blog/shared/data/appsetting.dart';

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;

  PortfolioTheme get pfTheme => theme.extension<PortfolioTheme>()!;

  Orientation get orientation => MediaQuery.orientationOf(this);

  AppLocalizations get l10n => AppLocalizations.of(this)!;

  Size get screenSize => MediaQuery.sizeOf(this);

  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);

  AppSettings get appSettings => AppData().appSettings!;

  Locale get currentLocale => Localizations.localeOf(this);
}
