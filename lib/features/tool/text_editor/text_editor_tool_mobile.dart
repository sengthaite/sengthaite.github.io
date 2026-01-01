import 'package:flutter_quill/flutter_quill.dart';
import 'package:sengthaite_blog/features/tool/text_editor/text_editor_tool_base.dart';

class TextEditorToolMobile extends TextEditorTool {
  final QuillController quillController;

  TextEditorToolMobile({super.key, required this.quillController})
    : super(config: QuillEditorConfig(), controller: quillController);
}
