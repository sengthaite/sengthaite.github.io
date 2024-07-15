import 'package:flutter/material.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/shared/markdown_custom/custom_text_node.dart';
import 'package:sengthaite_blog/shared/markdown_custom/latext.dart';
import 'package:sengthaite_blog/shared/markdown_custom/video.dart';
import 'package:url_launcher/url_launcher.dart';

class MarkdownViewMobile extends StatelessWidget {
  const MarkdownViewMobile({
    super.key,
    required this.markdown,
    this.title,
    this.textScaleFactor = 1,
  });

  final String markdown;
  final double textScaleFactor;
  final String? title;

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
        selfIndex: 0,
      ),
    ];
    controller.setTocList(tableOfContent);

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? ''),
      ),
      drawer: Drawer(
        child: TocWidget(controller: controller),
      ),
      body: MarkdownWidget(
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
    );
  }
}
