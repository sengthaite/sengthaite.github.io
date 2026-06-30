import 'package:flutter/material.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/features/portfolio/widgets/content_page.dart';

class PlatformToolsView extends StatelessWidget {
  /// Widget PlatformToolsView : display the platforms and tools used to complete the acitivity or the project
  ///
  /// Todo: add i icon which click to show tooltips explaining what is it about
  const PlatformToolsView({super.key, required this.data});

  final ContentPageData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
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
