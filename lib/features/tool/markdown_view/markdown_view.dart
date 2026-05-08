import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkdownView extends StatelessWidget {
  const MarkdownView({
    super.key,
    required this.markdown,
    required this.tocController,
    this.textScaleFactor = 1,
  });

  final String markdown;
  final double textScaleFactor;
  final TocController? tocController;

  @override
  Widget build(BuildContext context) {
    final config = MaterialTheme.isDark(context)
        ? MarkdownConfig.darkConfig
        : MarkdownConfig.defaultConfig;
    return MarkdownWidget(
      data: markdown,
      tocController: tocController,
      config: config.copy(
        configs: [
          PreConfig(theme: githubTheme),
          LinkConfig(
            onTap: (link) {
              final url = link;
              if (url.startsWith('http')) {
                launchUrl(Uri.parse(url));
              }
            },
          ),
        ],
      ),
    );
  }
}
