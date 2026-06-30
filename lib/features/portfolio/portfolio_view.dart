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

/// Todo: rewrite the mobile version to display properly
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
    double bottomPadding = MediaQuery.paddingOf(context).bottom;

    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 24.0,
              right: 24.0,
              bottom: 50.0 + bottomPadding,
            ),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: ProfileColumnView()),
                SliverPadding(
                  padding: EdgeInsets.only(top: 64),
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
                          fit: BoxFit.scaleDown,
                          child: PortfolioTabBar(
                            onSelected: (newSelectionType) =>
                                type.value = newSelectionType,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: ValueListenableBuilder(
                    valueListenable: type,
                    builder: (context, section, child) {
                      switch (section) {
                        case ContentSideSection.experience:
                          return Column(
                            children: context.experienceData
                                .map(
                                  (content) => FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: ExperienceWidget(data: content),
                                  ),
                                )
                                .toList(),
                          );
                        case ContentSideSection.education:
                          return Column(children: context.educationData);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: context.pfTheme.containerBgColor,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: MenuNavigation(overlayDirection: OverlayDirection.up),
              ),
            ),
          ),
        ],
      ),
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
