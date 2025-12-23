
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:sengthaite_blog/features/tool/text_editor/text_editor_tool_base.dart';


class TextEditorToolDesktop extends TextEditorTool {
   TextEditorToolDesktop({super.key}) : super(widget: Column(
      children: [
        Expanded(
          child: QuillEditor.basic(
            controller: QuillController.basic(),
            config: QuillEditorConfig(minHeight: 300),
          ),
        ),
      ],
    ));
}