import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/components/appbar/appbar_view.dart';
import 'package:sengthaite_blog/components/drawer/drawer_view.dart';
import 'package:sengthaite_blog/components/loading_screen.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/features/navigation/navigation.dart';
import 'package:sengthaite_blog/features/tab_bar_layout_content_view.dart';
import 'package:sengthaite_blog/features/tab_bar_layout_project_view.dart';
import 'package:sengthaite_blog/features/tab_bar_layout_tool_view.dart';
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

  Locale get locale => appSettings?.locale ?? Locale('en', 'US');

  bool isLoading = false;

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
    AppData().isLoading.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MaterialTheme theme = MaterialTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale,
      builder: DevicePreview.appBuilder,
      localizationsDelegates: const [
        FlutterQuillLocalizations.delegate,
        ...AppLocalizations.localizationsDelegates,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: theme.light(),
      darkTheme: theme.dark(),
      highContrastTheme: theme.lightMediumContrast(),
      highContrastDarkTheme: theme.darkMediumContrast(),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: false,
      ),
      navigatorKey: Navigation().navigatorKey,
      home: Builder(
        builder: (context) {
          return Stack(
            children: [
              AppLayout(
                defaultWidget: DefaultTabController(
                  animationDuration: Duration.zero,
                  initialIndex: 1,
                  length: 3,
                  child: Scaffold(
                    drawer: DrawerView(),
                    appBar: isFullScreenModel ? null : AppBarView(),
                    body: SafeArea(
                      child: ContentView(isFullScreenModel: isFullScreenModel),
                    ),
                    floatingActionButton: ToggleFullscreenView(
                      onSreenStateChange: (bool isFullScreen) => setState(() {
                        isFullScreenModel = isFullScreen;
                      }),
                    ),
                  ),
                ),
                context: context,
              ),
              if (isLoading)
                const Positioned.fill(child: Center(child: LoadingScreen())),
            ],
          );
        },
      ),
    );
  }
}

class ContentView extends StatelessWidget {
  const ContentView({super.key, required this.isFullScreenModel});

  final bool isFullScreenModel;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        TabBarLayoutContentView(hideBottomAppBar: isFullScreenModel),
        TabBarLayoutToolView(hideBottomAppBar: isFullScreenModel),
        TabBarLayoutProjectView(hideBottomAppBar: isFullScreenModel),
      ],
    );
  }
}

class ToggleFullscreenView extends StatelessWidget {
  const ToggleFullscreenView({super.key, required this.onSreenStateChange});

  final Function(bool) onSreenStateChange;

  @override
  Widget build(BuildContext context) {
    AppSettings? appSettings = AppData().appSettings;
    var newScreenState = !(appSettings?.isFullScreenMode ?? false);
    return FloatingActionButton.small(
      elevation: 1,
      onPressed: () {
        onSreenStateChange(newScreenState);
        appSettings?.isFullScreenMode = newScreenState;
        AppData().saveAppSettings();
      },
      child: Icon(
        newScreenState ? MdiIcons.arrowExpand : MdiIcons.arrowExpandAll,
      ),
    );
  }
}
