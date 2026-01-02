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
import 'package:sengthaite_blog/l10n/app_localizations.dart';
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
  AppSettings? get appSettings => AppData().appSettings;

  final List<DropdownMenuEntry<Locale>> menuEntries =
      <DropdownMenuEntry<Locale>>[
        DropdownMenuEntry(value: Locale('en', 'US'), label: 'English'),
        DropdownMenuEntry<Locale>(
          value: Locale('km', 'KH'),
          label: 'ភាសាខ្មែរ',
        ),
        DropdownMenuEntry<Locale>(value: Locale('zh', 'CN'), label: '中文'),
      ];

  bool get isFullScreenModel {
    return appSettings?.isFullScreenMode ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    MaterialTheme theme = MaterialTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // locale: DevicePreview.locale(context),
      locale: appSettings?.locale ?? Locale('en', 'US'),
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
          var appLocalization = AppLocalizations.of(context)!;
          return AppLayout(
            defaultWidget: DefaultTabController(
              animationDuration: Duration.zero,
              initialIndex: 1,
              length: 3,
              child: Scaffold(
                drawer: Drawer(
                  child: Column(
                    children: [
                      DrawerHeader(
                        child: Text(
                          appLocalization.settings,
                          style: MaterialTheme.textTheme().titleMedium,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownMenu(
                          dropdownMenuEntries: menuEntries,
                          initialSelection: appSettings?.locale,
                          onSelected: (value) => setState(() {
                            appSettings?.locale = value;
                            AppData().saveAppSettings();
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
                appBar: isFullScreenModel
                    ? null
                    : AppBar(
                        centerTitle: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AssetIcons.logo.image,
                            const SizedBox(width: 20),
                            Text(
                              appTitle,
                              style: MaterialTheme.textTheme().titleMedium,
                            ),
                          ],
                        ),
                        bottom: TabBar(
                          isScrollable: false,
                          physics: const NeverScrollableScrollPhysics(),
                          overlayColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width > 1100
                                ? screenSize.width * 0.35
                                : 20,
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: Colors.transparent,
                          tabs: [
                            Tab(text: appLocalization.article.toUpperCase()),
                            Tab(text: appLocalization.tool.toUpperCase()),
                            Tab(text: appLocalization.project.toUpperCase()),
                          ],
                        ),
                      ),
                body: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    TabBarLayoutContentView(
                      hideBottomAppBar: isFullScreenModel,
                    ),
                    TabBarLayoutToolView(hideBottomAppBar: isFullScreenModel),
                    TabBarLayoutProjectView(
                      hideBottomAppBar: isFullScreenModel,
                    ),
                  ],
                ),
                floatingActionButton: FloatingActionButton.small(
                  elevation: 1,
                  onPressed: () => setState(() {
                    var isFullScreenMode = !isFullScreenModel;
                    appSettings?.isFullScreenMode = isFullScreenMode;
                    AppData().saveAppSettings();
                  }),
                  child: Icon(
                    isFullScreenModel
                        ? MdiIcons.arrowExpand
                        : MdiIcons.arrowExpandAll,
                  ),
                ),
              ),
            ),
            context: context,
          );
        },
      ),
    );
  }
}
