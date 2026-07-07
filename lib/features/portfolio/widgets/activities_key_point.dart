import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/content_page.dart';

class ActivitiesKeyPointsView extends StatelessWidget {
  /// Widget ActivitiesKeyPointsView : list key points of each experience like role, type of work, team size, and
  ///
  const ActivitiesKeyPointsView({
    super.key,
    required this.sideSkillWidth,
    required this.data,
  });

  final double sideSkillWidth;
  final ContentPageData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: data.skillLists.map((e) {
        return Container(
          width: 170,
          decoration: BoxDecoration(
            border: context.pfTheme.border,
            color: context.pfTheme.buttonBgColor,
            borderRadius: BorderRadius.circular(64),
          ),
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [
              Icon(e.widget, size: 24, color: context.pfTheme.buttonFgColor),
              Expanded(
                child: Text(
                  e.title,
                  maxLines: 2,
                  style: context.pfTheme.sideMenuTitleStyle,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
