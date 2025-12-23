import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/monokai.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/shared/markdown_custom/custom_text_node.dart';
import 'package:sengthaite_blog/shared/markdown_custom/video.dart';
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
      markdownGenerator: MarkdownGenerator(
        generators: [videoGeneratorWithTag],
        textGenerator: (node, config, visitor) =>
            CustomTextNode(node.textContent, config, visitor),
      ),
      config: config.copy(
        configs: [
          PreConfig(theme: monokaiTheme),
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
