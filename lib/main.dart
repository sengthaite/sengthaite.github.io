import 'package:country_flags/country_flags.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive_ce/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/constants/app.constants.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/features/navigation/navigation.dart';
import 'package:sengthaite_blog/features/tab_bar_layout_content_view.dart';
import 'package:sengthaite_blog/features/tab_bar_layout_project_view.dart';
import 'package:sengthaite_blog/features/tab_bar_layout_tool_view.dart';
import 'package:sengthaite_blog/hive_registrar.g.dart';
import 'package:sengthaite_blog/shared/app.data.dart';
import 'package:sengthaite_blog/shared/app.layout.dart';
import 'package:sengthaite_blog/shared/data/appsetting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapters();
  Hive.init(".hive_data");
  await AppData().initData();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MainView(),
    ),
  );
}

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => _StateMainView();
}

class _StateMainView extends State<MainView> {
  AppSettings appSettings = AppSettings();

  final List<DropdownMenuEntry<String>> menuEntries =
      <DropdownMenuEntry<String>>[
        DropdownMenuEntry<String>(
          value: 'en',
          label: 'English',
          leadingIcon: CountryFlag.fromCountryCode(
            'US',
            theme: ImageTheme(width: 24, height: 24),
          ),
        ),
        DropdownMenuEntry<String>(
          value: 'km',
          label: 'Khmer',
          leadingIcon: CountryFlag.fromCountryCode(
            'KH',
            theme: ImageTheme(width: 24, height: 24),
          ),
        ),
        DropdownMenuEntry<String>(
          value: 'zh',
          label: 'Chinese',
          leadingIcon: CountryFlag.fromCountryCode(
            'CN',
            theme: ImageTheme(width: 24, height: 24),
          ),
        ),
      ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    MaterialTheme theme = MaterialTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // locale: DevicePreview.locale(context),
      locale: const Locale('km', 'KH'),
      builder: DevicePreview.appBuilder,
      localizationsDelegates: const [
        FlutterQuillLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('km', 'KH'),
        const Locale('zh', 'CN'),
      ],
      theme: theme.light(),
      darkTheme: theme.dark(),
      highContrastTheme: theme.lightMediumContrast(),
      highContrastDarkTheme: theme.darkMediumContrast(),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: false,
      ),
      navigatorKey: Navigation().navigatorKey,
      home: AppLayout(
        defaultWidget: DefaultTabController(
          animationDuration: Duration.zero,
          initialIndex: 1,
          length: 3,
          child: Scaffold(
            appBar: appSettings.isFullScreenMode
                ? null
                : AppBar(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AssetIcons.logo.image,
                        const SizedBox(width: 20),
                        Text(
                          appTitle,
                          style: MaterialTheme.textTheme().titleMedium!
                              .copyWith(fontSize: 28),
                        ),
                      ],
                    ),
                    bottom: TabBar(
                      isScrollable: false,
                      physics: const NeverScrollableScrollPhysics(),
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width > 1100
                            ? screenSize.width * 0.35
                            : 20,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      tabs: const [
                        Tab(text: tabTitleArticle),
                        Tab(text: tabTitleTool),
                        Tab(text: tabTitleProject),
                      ],
                    ),
                  ),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                TabBarLayoutContentView(
                  hideBottomAppBar: appSettings.isFullScreenMode,
                ),
                TabBarLayoutToolView(
                  hideBottomAppBar: appSettings.isFullScreenMode,
                ),
                TabBarLayoutProjectView(
                  hideBottomAppBar: appSettings.isFullScreenMode,
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.small(
              elevation: 1,
              onPressed: () => setState(() {
                appSettings.isFullScreenMode = !appSettings.isFullScreenMode;
              }),
              child: Icon(
                appSettings.isFullScreenMode
                    ? MdiIcons.arrowExpand
                    : MdiIcons.arrowExpandAll,
              ),
            ),
          ),
        ),
        context: context,
      ),
    );
  }
}
