import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/tab_bar_layout_navigation_view.dart';
import 'package:sengthaite_blog/components/tab_bar_navigation_title.dart';
import 'package:sengthaite_blog/constants/enum.constants.dart';
import 'package:sengthaite_blog/features/navigation/navigation.dart';

class TabBarLayoutViewItem {
  final TabBarNavigationTitle itemTitle;
  final Widget itemWidget;

  TabBarLayoutViewItem({
    required this.itemTitle,
    required this.itemWidget,
  });
}

class TabBarLayoutView extends StatefulWidget {
  const TabBarLayoutView({super.key, required this.section});

  final TabSection section;

  List<TabBarLayoutViewItem> get categories => [];

  @override
  State<StatefulWidget> createState() => TabBarLayoutViewState();
}

class TabBarLayoutViewState extends State<TabBarLayoutView> {
  final List<TabBarNavigationTitle> navigationTitleItems = [];

  removeUntil(TabBarNavigationTitle item) => setState(() =>
      navigationTitleItems.length = navigationTitleItems.indexOf(item) + 1);

  removeLast() => setState(() => navigationTitleItems.removeLast());

  addItem(TabBarNavigationTitle item) =>
      setState(() => navigationTitleItems.add(item));

  clearAllItems() => setState(() => navigationTitleItems.clear());

  GestureDetector categoryItem(
      {required TabBarNavigationTitle item, required Widget itemIcon}) {
    return GestureDetector(
      onTap: () => addItem(item),
      child: itemIcon,
    );
  }

  Function backOnClick(TabBarNavigationTitle item) => removeUntil(item);

  Widget get categoriesWidget => Wrap(
        spacing: 10,
        runSpacing: 10,
        children: widget.categories.map((e) {
          return categoryItem(item: e.itemTitle, itemIcon: e.itemWidget);
        }).toList(),
      );

  Expanded layoutWidget({required Widget child, required EdgeInsets padding}) {
    return Expanded(
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(252, 252, 252, 1),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
            width: 0.1,
            style: BorderStyle.solid,
          ),
        ),
        child: child,
      ),
    );
  }

  _updateNavigationState() {
    switch (widget.section) {
      case TabSection.content:
        Navigation().contentTabState = this;
        break;
      case TabSection.tool:
        Navigation().toolTabState = this;
        break;
      case TabSection.project:
        Navigation().projectTabState = this;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateNavigationState();
    return OrientationBuilder(
      builder: (context, orientation) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBarLayoutNavigationView(
            defaultText: "content",
            defaultTextClick: () => clearAllItems(),
            navigationTitleItems: navigationTitleItems,
          ),
          layoutWidget(
              child: navigationTitleItems.isNotEmpty
                  ? navigationTitleItems.last.widget
                  : SingleChildScrollView(
                      child: categoriesWidget,
                    ),
              padding: orientation == Orientation.landscape
                  ? const EdgeInsets.symmetric(vertical: 16, horizontal: 20)
                  : const EdgeInsets.all(8)),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Text(
              "Since 2024 (v2.0.0)",
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
