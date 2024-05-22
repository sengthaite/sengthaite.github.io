import 'package:sengthaite_blog/components/tab_bar_layout_view.dart';

class Navigation {
  static final Navigation _navigation = Navigation._();

  factory Navigation() => _navigation;

  TabBarLayoutViewState? contentTabState;
  TabBarLayoutViewState? projectTabState;
  TabBarLayoutViewState? toolTabState;

  Navigation._();
}
