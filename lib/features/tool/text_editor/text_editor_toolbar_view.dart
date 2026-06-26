import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:sengthaite_blog/extensions/build_context_ext.dart';
import 'package:sengthaite_blog/features/tool/text_editor/text_editor_extension.dart';

class TextEditorToolbarView extends StatelessWidget {
  const TextEditorToolbarView({super.key, required this.controller});

  final QuillController controller;

  @override
  Widget build(BuildContext context) {
    return QuillSimpleToolbar(
      controller: controller,
      config: QuillSimpleToolbarConfig(
        toolbarIconAlignment: WrapAlignment.start,
        toolbarIconCrossAlignment: WrapCrossAlignment.start,
        customButtons: [
          QuillToolbarCustomButtonOptions(
            icon: Icon(Symbols.markdown),
            tooltip: context.l10n.save("MD"),
            onPressed: () => controller.saveMarkdown(),
          ),
          QuillToolbarCustomButtonOptions(
            icon: Icon(Symbols.html),
            tooltip: context.l10n.save("HTML"),
            onPressed: () => controller.saveHTML(),
          ),
          QuillToolbarCustomButtonOptions(
            icon: Icon(Symbols.picture_as_pdf),
            tooltip: context.l10n.save("PDF"),
            onPressed: () => controller.savePDF(),
          ),
        ],
      ),
    );
  }
}
