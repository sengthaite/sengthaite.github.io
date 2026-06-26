import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/blog/tab_bar_navigation_title.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';

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
  List<TextSpan>? getNavItemWidget(ThemeData theme) {
    var items = widget.navigationTitleItems;
    if (items == null) {
      return null;
    }
    if (items.isEmpty) {
      return [];
    }
    var lastIndex = items.length - 1;
    for (final (index, item) in items.indexed) {
      if (index == lastIndex) {
        item.setTitleStyle(
          context.textTheme.titleSmall!.copyWith(
            color: context.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        );
        break;
      }
      item.setTitleStyle(
        context.textTheme.titleSmall!.copyWith(
          color: context.colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
      );
    }
    return items.map((e) => e.titleWidget).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
            child: RichText(
              softWrap: false,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: widget.defaultText,
                style: context.textTheme.titleSmall!.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
                recognizer: widget.defaultTextClick != null
                    ? (TapGestureRecognizer()
                        ..onTap = () => widget.defaultTextClick!())
                    : null,
                children: getNavItemWidget(context.theme),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
