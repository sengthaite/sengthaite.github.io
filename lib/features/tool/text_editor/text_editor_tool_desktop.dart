import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TextEditorToolDesktop extends StatelessWidget {
  const TextEditorToolDesktop({
    super.key,
    required this.controller,
  });

  final QuillController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: QuillEditor.basic(
            controller: controller,
            config: QuillEditorConfig(minHeight: 300),
          ),
        )
      ],
    );
  }
}
