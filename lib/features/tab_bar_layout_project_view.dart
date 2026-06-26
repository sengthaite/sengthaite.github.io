import 'package:sengthaite_blog/components/blog/tab_bar_layout_view.dart';
import 'package:sengthaite_blog/constants/enum.constants.dart';

class TabBarLayoutProjectView extends TabBarLayoutView {
  const TabBarLayoutProjectView({super.key, required this.hideBottomAppBar})
    : super(section: SectionType.project, hideBottomBar: hideBottomAppBar);

  final bool hideBottomAppBar;

  @override
  List<TabBarLayoutViewItem> get categories => [];
}
