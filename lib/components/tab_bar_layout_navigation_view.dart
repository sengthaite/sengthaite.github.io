import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/tab_bar_navigation_title.dart';
import 'package:sengthaite_blog/extensions/unique_ext.dart';

class TabBarLayoutNavigationView extends StatefulWidget {
  const TabBarLayoutNavigationView({
    super.key,
    required this.defaultText,
    this.defaultTextClick,
    this.navigationTitleItems,
  });

  final String defaultText;
  final void Function()? defaultTextClick;
  final List<TabBarNavigationTitle>? navigationTitleItems;

  @override
  State<StatefulWidget> createState() => _TabBarLayoutNavigtionState();
}

class _TabBarLayoutNavigtionState extends State<TabBarLayoutNavigationView> {
  List<TextSpan>? getNavItemWidget() {
    var items = widget.navigationTitleItems;
    if (items == null) {
      return null;
    }
    if (items.isEmpty) {
      return [];
    }
    items = items.unique((e) => e.index);
    var lastIndex = items.length - 1;
    for (final (index, item) in items.indexed) {
      if (index == lastIndex) {
        item.setTitleStyle(const TextStyle(color: Colors.blue));
        break;
      }
      item.setTitleStyle(const TextStyle(color: Colors.black));
    }
    return items.map((e) => e.titleWidget).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
                text: widget.defaultText,
                recognizer: widget.defaultTextClick != null
                    ? (TapGestureRecognizer()
                      ..onTap = () => widget.defaultTextClick!())
                    : null,
                children: getNavItemWidget()),
          ),
        ],
      ),
    );
  }
}
