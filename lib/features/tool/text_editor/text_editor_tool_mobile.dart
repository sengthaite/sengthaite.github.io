import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TextEditorToolMobile extends StatelessWidget {
  const TextEditorToolMobile({
    super.key,
    required this.controller,
  });

  final QuillController controller;

  //TODO: to update on change save text
  void _onChange() {
    final text = controller.plainTextEditingValue.text;
  }

  @override
  Widget build(BuildContext context) {

    controller.addListener(_onChange);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: QuillEditor.basic(
            controller: controller,
            config: QuillEditorConfig(),
          ),
        )
      ],
    );
  }
}
