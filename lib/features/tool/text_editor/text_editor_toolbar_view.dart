import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sengthaite_blog/features/tool/text_editor/text_editor_extension.dart';
import 'package:sengthaite_blog/l10n/app_localizations.dart';

class TextEditorToolbarView extends StatelessWidget {
  const TextEditorToolbarView({super.key, required this.controller});

  final QuillController controller;

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return QuillSimpleToolbar(
      controller: controller,
      config: QuillSimpleToolbarConfig(
        toolbarIconAlignment: WrapAlignment.start,
        toolbarIconCrossAlignment: WrapCrossAlignment.start,
        customButtons: [
          QuillToolbarCustomButtonOptions(
            icon: Icon(MdiIcons.languageMarkdown),
            tooltip: localization?.save("MD"),
            onPressed: () => controller.saveMarkdown(),
          ),
          QuillToolbarCustomButtonOptions(
            icon: Icon(MdiIcons.languageHtml5),
            tooltip: localization?.save("HTML"),
            onPressed: () => controller.saveHTML(),
          ),
          QuillToolbarCustomButtonOptions(
            icon: Icon(MdiIcons.filePdfBox),
            tooltip: localization?.save("PDF"),
            onPressed: () => controller.savePDF(),
          ),
        ],
      ),
    );
  }
}
