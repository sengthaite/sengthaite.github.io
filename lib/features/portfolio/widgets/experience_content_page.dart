import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/activities_key_point.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/content_page.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/platform_tool.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/role_title_description.dart';

class ExperienceWidget extends StatelessWidget {
  /// Widget ExperienceWidget : display pages of experiences for each role or position
  ///
  const ExperienceWidget({super.key, required this.data});
  final double sideSkillWidth = 140;

  final ContentPageData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (context.orientation == Orientation.landscape)
              SizedBox(width: sideSkillWidth),
            Expanded(child: RoleTitleDescriptionVew(data: data)),
          ],
        ),
        Row(
          children: [
            if (context.orientation == Orientation.landscape)
              SizedBox(
                width: sideSkillWidth,
                child: Padding(
                  padding: EdgeInsets.only(top: 12, right: 8),
                  child: ActivitiesKeyPointsView(
                    sideSkillWidth: sideSkillWidth,
                    data: data,
                  ),
                ),
              ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: context.pfTheme.containerBgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: context.pfTheme.borderColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      child: ActivityMainInformationView(data: data),
                    ),
                    Divider(color: context.pfTheme.borderColor, thickness: 0.5),
                    Container(
                      color: context.colorScheme.surface,
                      padding: const EdgeInsets.all(0),
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: data.content,
                      ),
                    ),
                    Divider(color: context.pfTheme.borderColor, thickness: 0.5),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      child: PlatformToolsView(data: data),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Widget ActivityMainInformationView : show the activity title, archivements, and strategies and keyword to success
class ActivityMainInformationView extends StatelessWidget {
  const ActivityMainInformationView({super.key, required this.data});

  final ContentPageData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                data.activityMainInformation,
                maxLines: 3,
                style: context.pfTheme.activityMainInformationTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (data.trailingMetricTitle != null)
              Text(
                data.trailingMetricTitle!,
                style: context.pfTheme.activityMainInformationTextStyle,
              ),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            Icon(Icons.vpn_key, color: context.pfTheme.buttonSelectedBgColor),
            Expanded(
              child: Text(
                data.skills,
                style: context.pfTheme.skillsTextStyle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
