import 'package:flutter/material.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/menu_navigation.dart';
import 'package:sengthaite_blog/components/portfolio/widgets/portfolio_page_view.dart';

// @Preview(name: "ContentSideView")
// Widget contentSidePreview() {
//   return Scaffold(body: ContentSideView());
// }

class ContentSideView extends StatefulWidget {
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
        children: [MenuNavigation(), SizedBox(height: 20), PortfolioPageView()],
      ),
    );
  }
}
