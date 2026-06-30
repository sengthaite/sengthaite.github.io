import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';

class TitleWidget {
  final String title;
  final IconData widget;

  TitleWidget({required this.title, required this.widget});
}

class ContentPageData {
  final String roleTitle;
  final String description;
  final List<TitleWidget> skillLists;

  final String experienceTitle;
  final String? trailingMetricTitle;
  final String skills;

  final Widget content;

  final List<String> platforms;

  ContentPageData({
    required this.roleTitle,
    required this.description,
    required this.skillLists,
    required this.experienceTitle,
    this.trailingMetricTitle,
    required this.skills,
    required this.content,
    required this.platforms,
  });

  Widget pageContentView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: PageContentView(data: this),
    );
  }
}

class ContentPage extends StatelessWidget {
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

class PageContentView extends StatelessWidget {
  const PageContentView({super.key, required this.data});

  final ContentPageData data;

  @override
  Widget build(BuildContext context) {
    return ExperienceWidget(data: data);
  }
}

class ExperienceWidget extends StatelessWidget {
  const ExperienceWidget({super.key, required this.data});
  final double sideSkillWidth = 140;

  final ContentPageData data;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                child: SkillListView(
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
                    child: ExperienceWrapperView(data: data),
                  ),
                  Divider(color: context.pfTheme.dividerColor),
                  Container(
                    color: context.colorScheme.surface,
                    alignment: Alignment.center,
                    child: data.content,
                  ),
                  Divider(color: context.pfTheme.dividerColor),
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
    );
  }
}

class PlatformToolsView extends StatelessWidget {
  const PlatformToolsView({super.key, required this.data});

  final ContentPageData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 5,
          children: [
            Icon(
              size: 16,
              Icons.developer_board,
              color: context.pfTheme.buttonFgColor,
            ),
            Text(
              context.l10n.platform_tools,
              style: context.pfTheme.sectionTitleStyle,
            ),
          ],
        ),
        Row(
          spacing: 6,
          children: data.platforms.map((e) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: context.pfTheme.border,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(e, style: context.pfTheme.textStyle),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ExperienceWrapperView extends StatelessWidget {
  const ExperienceWrapperView({super.key, required this.data});

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
              data.experienceTitle,
              maxLines: 3,
              style: context.pfTheme.experienceTitleTextStyle,
              overflow: TextOverflow.ellipsis,
            ),
            if (data.trailingMetricTitle != null)
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  data.trailingMetricTitle!,
                  style: context.pfTheme.experienceTitleTextStyle,
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

class SkillListView extends StatelessWidget {
  const SkillListView({
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
                  style: context.pfTheme.textStyle,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class RoleTitleDescriptionVew extends StatelessWidget {
  const RoleTitleDescriptionVew({super.key, required this.data});

  final ContentPageData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.roleTitle, style: context.pfTheme.roleTitleTextStyle),
          Text(data.description, style: context.pfTheme.roleDetailTextStyle),
        ],
      ),
    );
  }
}
