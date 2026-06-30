import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';

class ContentPage extends StatelessWidget {
  /// Widget ContentPage : to display the whole content in pageview
  ///
  const ContentPage({
    super.key,
    required this.data,
    required this.controller,
    this.onPageChanged,
  });

  final List<Widget> data;
  final PageController controller;
  final void Function(int)? onPageChanged;

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textTheme.labelLarge;
    if (data.isEmpty) {
      return Center(
        child: Text(
          context.l10n.empty_content,
          style: textStyle,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }
    var pageView = PageView(
      controller: controller,
      allowImplicitScrolling: false,
      physics: PageScrollPhysics(),
      padEnds: false,
      onPageChanged: (int page) {
        onPageChanged?.call(page);
      },
      children: data,
    );
    return pageView;
  }
}

/// Each role and resource to complete each activity
class TitleWidget {
  final String title;
  final IconData widget;

  TitleWidget({required this.title, required this.widget});
}

/// Data of each page view
class ContentPageData {
  final String roleTitle;
  final String description;
  final List<TitleWidget> skillLists;

  final String ActivityMainInformation;
  final String? trailingMetricTitle;
  final String skills;

  final Widget content;

  final List<String> platforms;

  ContentPageData({
    required this.roleTitle,
    required this.description,
    required this.skillLists,
    required this.ActivityMainInformation,
    this.trailingMetricTitle,
    required this.skills,
    required this.content,
    required this.platforms,
  });
}
