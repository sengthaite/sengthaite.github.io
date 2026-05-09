import 'package:flutter_quill/flutter_quill.dart';
import 'package:sengthaite_blog/features/tool/text_editor/text_editor_tool_base.dart';

class TextEditorToolMobile extends TextEditorTool {
  TextEditorToolMobile({super.key, required Function(QuillController) onInit})
    : super(
        config: QuillEditorConfig(
          autoFocus: false,
          // searchConfig: QuillSearchConfig(
          //   searchEmbedMode: SearchEmbedMode.plainText,
          // ),
        ),
      );
}
