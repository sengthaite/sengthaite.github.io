import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:sengthaite_blog/components/main_view.dart';
import 'package:sengthaite_blog/components/portfolio/portfolio_content_view.dart';
import 'package:sengthaite_blog/constants/app_theme.dart';
import 'package:sengthaite_blog/l10n/app_localizations.dart';

@Preview(name: "portfolio")
Widget preview() {
  return PortfolioView();
}

class PortfolioView extends StatelessWidget {
  final navKey = GlobalKey<NavigatorState>();
  final messengerKey = GlobalKey<ScaffoldMessengerState>();
  final Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => PortfolioContentView(),
    '/blog': (context) => MainView(),
  };
  final String initRoutePath = "/";
  final String title = "Portfolio";
  final String restoredScopeId = "restoration_scope_id";

  PortfolioView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: super.key,
      navigatorKey: navKey,
      scaffoldMessengerKey: messengerKey,
      // home: PortfolioContentView(),
      routes: routes,
      initialRoute: initRoutePath,
      onGenerateRoute: (settings) {
        // Dynamic routing, passing arguments to a screen (via settings.arguments), and handling unknown routes.
        return null;
      },
      onGenerateInitialRoutes: (route) {
        // Deep linking or creating a specific back-stack. For example, if a user deep links to /settings/profile, this property allows you to build a stack where the Profile screen is on top of the Settings screen, providing a working "Back" button.
        return [
          MaterialPageRoute(builder: (context) => PortfolioContentView()),
        ];
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Container(),
        );
      },
      onNavigationNotification: (navNotification) {
        return true;
      },
      navigatorObservers: const <NavigatorObserver>[],
      builder: (context, widget) {
        return widget ?? Container();
      },
      title: title,
      onGenerateTitle: (context) => title.toUpperCase(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      highContrastTheme: AppTheme.highContrastLightTheme,
      highContrastDarkTheme: AppTheme.highContrastDarkTheme,
      themeMode: ThemeMode.system,
      themeAnimationDuration: Duration(milliseconds: 5),
      themeAnimationCurve: Curves.ease,
      locale: Locale("en", "US"),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      localeResolutionCallback: (locale, itLocale) {
        return Locale("en", "US");
      },
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowMaterialGrid: false,
      showPerformanceOverlay: false,
      checkerboardRasterCacheImages: false,
      checkerboardOffscreenLayers: false,
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: true,
      shortcuts: {},
      actions: {},
      restorationScopeId: restoredScopeId,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.stylus,
          PointerDeviceKind.trackpad,
          PointerDeviceKind.unknown,
        },
      ),
      themeAnimationStyle: AnimationStyle(),
    );
  }
}
