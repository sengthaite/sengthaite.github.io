import 'package:flutter/material.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/shared/markdown_custom/custom_text_node.dart';
import 'package:sengthaite_blog/shared/markdown_custom/latext.dart';
import 'package:sengthaite_blog/shared/markdown_custom/video.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkdownViewDesktop extends StatelessWidget {
  const MarkdownViewDesktop({
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
    final TocController controller = TocController();
    List<Toc> tableOfContent = [
      Toc(
          node: HeadingNode(const H1Config(), WidgetVisitor()),
          widgetIndex: 0,
          selfIndex: 0),
    ];
    controller.setTocList(tableOfContent);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: MarkdownWidget(
            data: markdown,
            tocController: controller,
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
          ),
        ),
        Expanded(
          child: TocWidget(controller: controller),
        )
      ],
    );
  }
}
