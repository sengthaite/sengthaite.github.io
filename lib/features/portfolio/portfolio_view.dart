import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/features/portfolio/content_side_view.dart';
import 'package:sengthaite_blog/features/portfolio/footer_note.dart';
import 'package:sengthaite_blog/features/portfolio/profile_side_view.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/experience_content_page.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/landscape_scroll_container.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/menu_navigation.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/overlay_dropdown.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/portfolio_page_view.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/portfolio_tab_bar.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/zoomable_content.dart';
import 'package:sengthaite_blog/shared/app.layout.dart';

class PortfolioView extends StatelessWidget {
  const PortfolioView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onPrimary,
      body: AppLayout(
        defaultWidget: LandscapePortfolioView(),
        landscapeWidget: LandscapePortfolioView(),
        portraitWidget: PortraitPortfolioView(),
      ),
    );
  }
}

class PortraitPortfolioView extends StatelessWidget {
  PortraitPortfolioView({super.key});

  final ValueNotifier<ContentSideSection> type = ValueNotifier(
    ContentSideSection.experience,
  );

  final List<Widget> educations = [
    AssetIcons.bachelor.image,
    AssetIcons.itday.image,
    AssetIcons.peermentor.image,
    AssetIcons.volunteeryvsd.image,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: ProfileColumnView()),
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 0),
                  sliver: SliverLayoutBuilder(
                    builder: (context, constraints) {
                      final isPinned = constraints.scrollOffset > 0;
                      return SliverAppBar(
                        pinned: true,
                        backgroundColor: isPinned
                            ? context.colorScheme.onPrimary
                            : Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: Colors.transparent,
                        title: FittedBox(
                          fit: BoxFit.fitHeight,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: PortfolioTabBar(
                              onSelected: (newSelectionType) =>
                                  type.value = newSelectionType,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: ZoomableContent(
                    child: ValueListenableBuilder(
                      valueListenable: type,
                      builder: (context, section, child) {
                        switch (section) {
                          case ContentSideSection.experience:
                            return Column(
                              children: context.experienceData
                                  .map(
                                    (content) =>
                                        ExperienceWidget(data: content),
                                  )
                                  .toList(),
                            );
                          case ContentSideSection.education:
                            return Column(children: context.educationData);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: context.pfTheme.containerBgColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.shadow.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: Offset(0, -4),
              ),
            ],
          ),

          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: MenuNavigation(overlayDirection: OverlayDirection.up),
          ),
        ),
      ],
    );
  }
}

class LandscapePortfolioView extends StatelessWidget {
  const LandscapePortfolioView({super.key});

  @override
  Widget build(BuildContext context) {
    return LandscapeScrollContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 18,
              children: [ContentSideView(), ProfileSideView()],
            ),
          ),
          SizedBox(height: 12),
          Footnote(),
        ],
      ),
    );
  }
}
