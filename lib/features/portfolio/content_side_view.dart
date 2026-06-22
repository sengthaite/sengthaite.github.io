import 'package:flutter/material.dart';
import 'package:sengthaite_blog/features/portfolio/inside_content_view.dart';
import 'package:sengthaite_blog/features/portfolio/menu_view.dart';

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
      flex: 3,
      child: Column(
        children: [
          MenuNavigation(),
          SizedBox(height: 40),
          InsideContentWidget(),
        ],
      ),
    );
  }
}
