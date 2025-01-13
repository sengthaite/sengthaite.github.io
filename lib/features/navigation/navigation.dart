import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/tab_bar_layout_view.dart';

class Navigation {
  static final Navigation _navigation = Navigation._();

  factory Navigation() => _navigation;

  TabBarLayoutViewState? contentTabState;
  TabBarLayoutViewState? projectTabState;
  TabBarLayoutViewState? toolTabState;

  BuildContext? tabBarDetailContext;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  BuildContext get context => navigatorKey.currentContext!;

  Navigation._();
}
