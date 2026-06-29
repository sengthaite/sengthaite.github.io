import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/align_scroll_container.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/menu_navigation.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/portfolio_page_view.dart';
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
        desktopWidget: LandscapePortfolioView(),
        mobileWidget: PortraitPortfolioView(),
      ),
    );
  }
}

class PortraitPortfolioView extends StatelessWidget {
  const PortraitPortfolioView({super.key});

  @override
  Widget build(BuildContext context) {
    return AlignScrollPortraitContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MenuNavigation(),
          ProfileSideView(),
          PortfolioPageView(),
          SizedBox(height: 18),
          FooterView(),
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
