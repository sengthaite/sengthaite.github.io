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
            configurations: QuillEditorConfigurations(
              controller: controller,
              minHeight: 300,
              sharedConfigurations: const QuillSharedConfigurations(
                locale: Locale('en'),
              ),
            ),
          ),
        )
      ],
    );
  }
}
