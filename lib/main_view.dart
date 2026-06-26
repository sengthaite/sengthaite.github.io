import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:sengthaite_blog/components/appbar/appbar_with_tab.dart';
import 'package:sengthaite_blog/components/blog/loading_screen.dart';
import 'package:sengthaite_blog/components/blog/main_content_view.dart';
import 'package:sengthaite_blog/components/drawer/drawer_view.dart';
import 'package:sengthaite_blog/features/navigation/navigation.dart';
import 'package:sengthaite_blog/l10n/app_localizations.dart';
import 'package:sengthaite_blog/shared/app.data.dart';
import 'package:sengthaite_blog/shared/app.layout.dart';
import 'package:sengthaite_blog/shared/data/appsetting.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => _StateMainView();
}

class _StateMainView extends State<MainView> {
  AppSettings? get appSettings => AppData().appSettings;

  bool isFullScreenModel = false;

  bool isLoading = false;

  final Color brandSeedColor = Colors.blue;

  void onLoading() {
    if (mounted) {
      setState(() {
        isLoading = AppData().isLoading.value;
      });
    } else {
      isLoading = AppData().isLoading.value;
    }
  }

  @override
  void initState() {
    super.initState();
    isFullScreenModel = appSettings?.isFullScreenMode ?? false;
    AppData().isLoading.addListener(onLoading);
  }

  @override
  void dispose() {
    super.dispose();
    AppData().isLoading.removeListener(onLoading);
    // AppData().isLoading.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable:
          appSettings?.currentLocale ?? ValueNotifier(const Locale('en', 'US')),
      builder: (context, locale, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: locale,
        builder: DevicePreview.appBuilder,
        localizationsDelegates: const [
          FlutterQuillLocalizations.delegate,
          ...AppLocalizations.localizationsDelegates,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: brandSeedColor,
            brightness: Brightness.light,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: brandSeedColor,
            brightness: Brightness.dark,
          ),
        ),
        scrollBehavior: const MaterialScrollBehavior().copyWith(
          scrollbars: false,
        ),
        navigatorKey: Navigation().navigatorKey,
        initialRoute: "/",
        home: OldLayoutView(
          isFullScreenModel: isFullScreenModel,
          isLoading: isLoading,
        ),
      ),
    );
  }
}

class OldLayoutView extends StatelessWidget {
  const OldLayoutView({
    super.key,
    required this.isFullScreenModel,
    required this.isLoading,
  });

  final bool isFullScreenModel;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppLayout(
          defaultWidget: DefaultTabController(
            animationDuration: Duration.zero,
            initialIndex: 0,
            length: 3,
            child: Scaffold(
              drawer: DrawerView(),
              appBar: isFullScreenModel ? null : AppBarViewTab(),
              body: SafeArea(
                child: ContentView(isFullScreenModel: isFullScreenModel),
              ),
            ),
          ),
        ),
        if (isLoading)
          const Positioned.fill(child: Center(child: LoadingScreen())),
      ],
    );
  }
}
