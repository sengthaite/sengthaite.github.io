import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/tab_bar_layout_navigation_view.dart';
import 'package:sengthaite_blog/components/tab_bar_navigation_title.dart';
import 'package:sengthaite_blog/constants/enum.constants.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/features/navigation/navigation.dart';

class TabBarLayoutViewItem {
  final TabBarNavigationTitle itemTitle;
  final Widget itemWidget;

  TabBarLayoutViewItem({required this.itemTitle, required this.itemWidget});
}

class TabBarLayoutView extends StatefulWidget {
  const TabBarLayoutView({
    super.key,
    required this.section,
    required this.hideBottomBar,
  });

  final TabSection section;
  final bool hideBottomBar;

  List<TabBarLayoutViewItem> get categories => [];

  @override
  State<StatefulWidget> createState() => TabBarLayoutViewState();
}

class TabBarLayoutViewState extends State<TabBarLayoutView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final List<TabBarNavigationTitle> navigationTitleItems = [];

  String _defaultContentTitle = "Content";

  String _defaultEmptyContentTitle = "Empty Content";

  dynamic removeUntil(TabBarNavigationTitle item) => setState(
    () => navigationTitleItems.length = navigationTitleItems.indexOf(item) + 1,
  );

  void removeLast() => setState(() => navigationTitleItems.removeLast());

  void addItem(TabBarNavigationTitle item) =>
      setState(() => navigationTitleItems.add(item));

  void clearAllItems() => setState(() => navigationTitleItems.clear());

  GestureDetector categoryItem({
    required TabBarNavigationTitle item,
    required Widget itemIcon,
  }) {
    return GestureDetector(onTap: () => addItem(item), child: itemIcon);
  }

  Function backOnClick(TabBarNavigationTitle item) => removeUntil(item);

  Widget get categoriesWidget => Wrap(
    spacing: 10,
    runSpacing: 10,
    alignment: WrapAlignment.spaceEvenly,
    children: widget.categories.map((e) {
      return categoryItem(item: e.itemTitle, itemIcon: e.itemWidget);
    }).toList(),
  );

  Widget layoutWidget({required Widget child, required EdgeInsets padding}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(
              color: MaterialTheme.colorScheme(context).surfaceContainer,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  void _updateNavigationState() {
    switch (widget.section) {
      case TabSection.content:
        Navigation().contentTabState = this;
        _defaultContentTitle = "Content";
        _defaultEmptyContentTitle = "Empty Content";
        break;
      case TabSection.tool:
        Navigation().toolTabState = this;
        _defaultContentTitle = "Tool";
        _defaultEmptyContentTitle = "Not available";
        break;
      case TabSection.project:
        Navigation().projectTabState = this;
        _defaultContentTitle = "Project";
        _defaultEmptyContentTitle = "Not available";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Navigation().tabBarDetailContext = context;
    _updateNavigationState();
    return OrientationBuilder(
      builder: (context, orientation) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBarLayoutNavigationView(
            defaultText: _defaultContentTitle,
            defaultTextClick: () => clearAllItems(),
            navigationTitleItems: navigationTitleItems,
          ),
          layoutWidget(
            child: navigationTitleItems.isNotEmpty
                ? Stack(
                    children: navigationTitleItems
                        .map((e) => e.widget)
                        .toList(),
                  )
                : ((widget.categories.isNotEmpty)
                      ? SingleChildScrollView(child: categoriesWidget)
                      : Center(child: Text(_defaultEmptyContentTitle))),
            padding: orientation == Orientation.landscape
                ? const EdgeInsets.symmetric(vertical: 16, horizontal: 20)
                : const EdgeInsets.all(8),
          ),
          if (!widget.hideBottomBar)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text("Since 2024 (v2.0.0)", textAlign: TextAlign.center),
            ),
        ],
      ),
    );
  }
}
