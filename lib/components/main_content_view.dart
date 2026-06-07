import 'package:flutter/material.dart';
import 'package:sengthaite_blog/features/tab_bar_layout_content_view.dart';
import 'package:sengthaite_blog/features/tab_bar_layout_project_view.dart';
import 'package:sengthaite_blog/features/tab_bar_layout_tool_view.dart';

class ContentView extends StatelessWidget {
  const ContentView({super.key, required this.isFullScreenModel});

  final bool isFullScreenModel;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        TabBarLayoutContentView(hideBottomAppBar: isFullScreenModel),
        TabBarLayoutToolView(hideBottomAppBar: isFullScreenModel),
        TabBarLayoutProjectView(hideBottomAppBar: isFullScreenModel),
      ],
    );
  }
}
