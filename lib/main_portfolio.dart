import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:sengthaite_blog/constants/app_theme.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/features/portfolio/portfolio_view.dart';
import 'package:sengthaite_blog/l10n/app_localizations.dart';
import 'package:sengthaite_blog/main_view.dart';

@Preview(name: "portfolio")
Widget preview() {
  return MainPortfolioView();
}

sealed class MainPortfolioViewConstant extends StatelessWidget {
  final navKey = GlobalKey<NavigatorState>();
  final messengerKey = GlobalKey<ScaffoldMessengerState>();
  final Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => PortfolioView(),
    '/blog': (context) => MainView(),
  };
  final String initRoutePath = "/";
  final String title = "Portfolio";
  final String restoredScopeId = "restoration_scope_id";

  MainPortfolioViewConstant({super.key});
}

class MainPortfolioView extends MainPortfolioViewConstant {
  MainPortfolioView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("--- Building the portfolio");
    return ListenableBuilder(
      listenable: Listenable.merge([
        context.appSettings.currentLocale,
        context.appSettings.currentThemeMode,
      ]),
      builder: (context, child) {
        return MaterialApp(
          // key: super.key,
          navigatorKey: navKey,
          scaffoldMessengerKey: messengerKey,
          // home: PortfolioView(),
          routes: routes,
          initialRoute: initRoutePath,
          onGenerateRoute: (settings) {
            // Dynamic routing, passing arguments to a screen (via settings.arguments), and handling unknown routes.
            return null;
          },
          onGenerateInitialRoutes: (route) {
            // Deep linking or creating a specific back-stack. For example, if a user deep links to /settings/profile, this property allows you to build a stack where the Profile screen is on top of the Settings screen, providing a working "Back" button.
            return [MaterialPageRoute(builder: (context) => PortfolioView())];
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
          builder: (context, widget) => widget ?? Container(),
          title: title,
          onGenerateTitle: (context) => title.toUpperCase(),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          highContrastTheme: AppTheme.highContrastLightTheme,
          highContrastDarkTheme: AppTheme.highContrastDarkTheme,
          themeMode: context.appSettings.currentThemeMode.value,
          themeAnimationDuration: Duration(milliseconds: 5),
          themeAnimationCurve: Curves.ease,
          locale: context.appSettings.currentLocale.value,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          localeResolutionCallback: (locale, itLocale) =>
              locale ?? Locale('en'),
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
      },
    );
  }
}
