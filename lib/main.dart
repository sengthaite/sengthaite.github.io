import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/constants/app.constants.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/constants/style.constants.dart';
import 'package:sengthaite_blog/features/tab_bar_layout_content_view.dart';
import 'package:sengthaite_blog/features/tab_bar_layout_project_view.dart';
import 'package:sengthaite_blog/features/tab_bar_layout_tool_view.dart';
import 'package:sengthaite_blog/shared/app.data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppData().initData();
  runApp(const MainView());
}

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => _StateMainView();
}

class _StateMainView extends State<MainView> {
  List<Widget> widgets = [];

  bool hideAppBar = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
        primaryColor: Colors.white,
      ),
      home: OrientationBuilder(
        builder: (context, orientation) => DefaultTabController(
          animationDuration: Duration.zero,
          length: 3,
          child: Padding(
            padding: Orientation.landscape == orientation
                ? const EdgeInsets.symmetric(vertical: 12, horizontal: 24)
                : const EdgeInsets.all(8),
            child: Scaffold(
              appBar: hideAppBar
                  ? null
                  : AppBar(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AssetIcons.logo.image,
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            appTitle,
                            style: pageTitleTextStyle,
                          )
                        ],
                      ),
                      bottom: TabBar(
                        isScrollable: false,
                        physics: const NeverScrollableScrollPhysics(),
                        overlayColor:
                            WidgetStateProperty.all(Colors.transparent),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width > 1100
                              ? screenSize.width * 0.35
                              : 20,
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: tabBarSelectedTitleStyle,
                        indicatorColor: Colors.blueAccent,
                        unselectedLabelStyle: tabBarUnselectedTitleStyle,
                        dividerColor: Colors.transparent,
                        tabs: const [
                          Tab(text: tabTitleArticle),
                          Tab(text: tabTitleTool),
                          Tab(text: tabTitleProject)
                        ],
                      ),
                    ),
              body: const TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  TabBarLayoutContentView(),
                  TabBarLayoutToolView(),
                  TabBarLayoutProjectView(),
                ],
              ),
              floatingActionButton: FloatingActionButton.small(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.blue,
                hoverColor: Colors.lightBlue,
                elevation: 1,
                onPressed: () => {
                  setState(() {
                    hideAppBar = !hideAppBar;
                  })
                },
                child: Icon(
                  hideAppBar ? MdiIcons.arrowExpand : MdiIcons.arrowExpandAll,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
