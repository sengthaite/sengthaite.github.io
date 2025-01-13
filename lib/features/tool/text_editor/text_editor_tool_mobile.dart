import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TextEditorToolMobile extends StatelessWidget {
  const TextEditorToolMobile({
    super.key,
    required this.controller,
  });

  final QuillController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: QuillEditor.basic(
            controller: controller,
            configurations: QuillEditorConfigurations(
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
