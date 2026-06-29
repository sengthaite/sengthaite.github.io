import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/align_scroll_container.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/content_page.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/menu_navigation.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/overlay_dropdown.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/portfolio_detail_tab_view.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/portfolio_page_view.dart';
import 'package:sengthaite_blog/constants/image.constants.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/features/portfolio/content_side_view.dart';
import 'package:sengthaite_blog/features/portfolio/footer_view.dart';
import 'package:sengthaite_blog/features/portfolio/profile_side_view.dart';
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

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;

  StickyHeaderDelegate({
    required this.child,
    this.height = 60.0, // Set your preferred header height
  });

  @override
  double get minExtent => height; // The size of the header when pinned

  @override
  double get maxExtent => height; // The size of the header when expanded

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // Wrap in a Material or Container with a background color
    // so underlying content doesn't bleed through while scrolling.
    return Material(
      elevation: overlapsContent
          ? 4.0
          : 0.0, // Adds shadow when content scrolls under
      child: SizedBox.expand(child: child),
    );
  }

  @override
  bool shouldRebuild(covariant StickyHeaderDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
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
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
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
                        title: PortfolioDetailTabView(
                          onSelected: (newSelectionType) =>
                              type.value = newSelectionType,
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
                                  (content) => PageContentView(data: content),
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
    return AlignScrollContainer(
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
          FooterView(),
        ],
      ),
    );
  }
}
