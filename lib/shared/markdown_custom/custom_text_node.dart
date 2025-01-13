import 'package:markdown/markdown.dart' as m;
import 'package:markdown_widget/markdown_widget.dart';

import 'html_support.dart';

class CustomTextNode extends ElementNode {
  final String text;
  final MarkdownConfig config;
  final WidgetVisitor visitor;

  CustomTextNode(this.text, this.config, this.visitor);

  @override
  void onAccepted(SpanNode parent) {
    final textStyle =
        config.p.textStyle.merge(parentStyle).copyWith(fontSize: 14);
    children.clear();
    if (!text.contains(htmlRep)) {
      accept(TextNode(text: text, style: textStyle));
      return;
    }
    final spans = parseHtml(
      m.Text(text),
      visitor: WidgetVisitor(
        config: visitor.config,
        generators: visitor.generators,
        richTextBuilder: visitor.richTextBuilder,
      ),
      parentStyle: parentStyle,
    );
    for (var element in spans) {
      accept(element);
    }
  }
}
