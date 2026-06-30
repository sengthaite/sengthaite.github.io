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
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: sideSkillWidth),
              RoleTitleDescriptionVew(data: data),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Container(
                decoration: BoxDecoration(
                  color: context.pfTheme.containerBgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: context.pfTheme.borderColor,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      child: ActivityMainInformation(data: data),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        color: context.colorScheme.surface,
                        alignment: Alignment.center,
                        child: data.content,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: PlatformToolsView(data: data),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Widget ActivityMainInformation : show the activity title, archivements, and strategies and keyword to success
class ActivityMainInformation extends StatelessWidget {
  const ActivityMainInformation({super.key, required this.data});

  final ContentPageData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data.ActivityMainInformation,
              maxLines: 3,
              style: context.pfTheme.ActivityMainInformationTextStyle,
              overflow: TextOverflow.ellipsis,
            ),
            if (data.trailingMetricTitle != null)
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  data.trailingMetricTitle!,
                  style: context.pfTheme.ActivityMainInformationTextStyle,
                ),
              ),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            Icon(Icons.vpn_key, color: context.pfTheme.buttonSelectedBgColor),
            Text(
              data.skills,
              style: context.pfTheme.skillsTextStyle,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
