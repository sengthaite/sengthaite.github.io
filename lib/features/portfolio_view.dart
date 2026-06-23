import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:sengthaite_blog/components/main_view.dart';
import 'package:sengthaite_blog/features/portfolio/content_side_view.dart';
import 'package:sengthaite_blog/features/portfolio/footer_view.dart';
import 'package:sengthaite_blog/features/portfolio/profile_side_view.dart';

@Preview(name: "portfolio")
Widget preview() {
  return PortfolioView();
}

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: Color(0xFFD40004),
);

ThemeData darkTheme = ThemeData();

ThemeData highContrastLightTheme = lightTheme;

ThemeData highContrastDarkTheme = darkTheme;

class PortfolioView extends StatelessWidget {
  final navKey = GlobalKey<NavigatorState>();
  final messengerKey = GlobalKey<ScaffoldMessengerState>();
  final Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => DashboardView(),
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
      // home: DashboardView(),
      routes: routes,
      initialRoute: initRoutePath,
      onGenerateRoute: (settings) {
        // Dynamic routing, passing arguments to a screen (via settings.arguments), and handling unknown routes.
        return null;
      },
      onGenerateInitialRoutes: (route) {
        // Deep linking or creating a specific back-stack. For example, if a user deep links to /settings/profile, this property allows you to build a stack where the Profile screen is on top of the Settings screen, providing a working "Back" button.
        return [MaterialPageRoute(builder: (context) => DashboardView())];
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
      onGenerateTitle: (context) {
        return title.toUpperCase();
      },
      color: Colors.red,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      highContrastTheme: ThemeData.light(),
      highContrastDarkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      themeAnimationDuration: Duration(seconds: 5),
      themeAnimationCurve: Curves.linear,
      locale: Locale("en", "US"),
      localizationsDelegates: [],
      localeListResolutionCallback: (locale, itLocale) {
        return null;
      },
      localeResolutionCallback: (locale, itLocale) {
        return Locale("en", "US");
      },
      supportedLocales: const <Locale>[Locale('en', 'US')],
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

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: 1920,
              height: 1080,
              padding: const EdgeInsets.only(top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 18,
                      children: [ContentSideView(), ProfileSideView()],
                    ),
                  ),
                  SizedBox(height: 24),
                  FooterView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
