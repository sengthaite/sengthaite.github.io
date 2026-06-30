import 'package:flutter/material.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/menu_navigation.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/overlay_dropdown.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/portfolio_page_view.dart';

class ContentSideView extends StatefulWidget {
  /// Widget ContentSideView : the wrapper of the left handside content for landscape display
  ///
  const ContentSideView({super.key});

  @override
  State<ContentSideView> createState() => _ContentSideViewState();
}

class _ContentSideViewState extends State<ContentSideView> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Column(
        children: [
          MenuNavigation(overlayDirection: OverlayDirection.down),
          SizedBox(height: 20),
          PortfolioPageView(),
        ],
      ),
    );
  }
}
