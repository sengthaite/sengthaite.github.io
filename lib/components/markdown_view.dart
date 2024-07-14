import 'package:flutter/material.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/blocks/all.dart';
import 'package:markdown_widget/widget/markdown.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/shared/markdown_custom/custom_text_node.dart';
import 'package:sengthaite_blog/shared/markdown_custom/latext.dart';
import 'package:sengthaite_blog/shared/markdown_custom/video.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkdownView extends StatelessWidget {
  const MarkdownView({
    super.key,
    required this.markdown,
    this.textScaleFactor = 1,
  });

  final String markdown;
  final double textScaleFactor;

  @override
  Widget build(BuildContext context) {
    final config = MaterialTheme.isDark(context)
        ? MarkdownConfig.darkConfig
        : MarkdownConfig.defaultConfig;
    return MarkdownWidget(
      data: markdown,
      markdownGenerator: MarkdownGenerator(
        generators: [latexGenerator, videoGeneratorWithTag],
        inlineSyntaxList: [LatexSyntax()],
        textGenerator: (node, config, visitor) =>
            CustomTextNode(node.textContent, config, visitor),
      ),
      config: config.copy(configs: [
        LinkConfig(onTap: (link) {
          final url = link;
          if (url.startsWith('http')) {
            launchUrl(Uri.parse(url));
          }
        })
      ]),
    );
  }
}
