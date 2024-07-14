import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TextEditorToolMobile extends StatelessWidget {
  const TextEditorToolMobile({super.key, required this.controller});

  final QuillController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        QuillToolbar.simple(
          configurations: QuillSimpleToolbarConfigurations(
            controller: controller,
            toolbarIconAlignment: WrapAlignment.start,
            toolbarIconCrossAlignment: WrapCrossAlignment.start,
            sharedConfigurations: const QuillSharedConfigurations(
              locale: Locale('en'),
            ),
            showAlignmentButtons: false,
            showBackgroundColorButton: false,
            showBoldButton: true,
            showCenterAlignment: false,
            showClearFormat: false,
            showClipboardCopy: false,
            showClipboardCut: false,
            showClipboardPaste: false,
            showCodeBlock: false,
            showColorButton: false,
            showDirection: false,
            showDividers: false,
            showFontFamily: true,
            showFontSize: true,
            showHeaderStyle: false,
            showIndent: false,
            showInlineCode: true,
            showItalicButton: false,
            showJustifyAlignment: true,
            showLeftAlignment: false,
            showLink: false,
            showListBullets: true,
            showListCheck: true,
            showListNumbers: true,
            showQuote: false,
            showRedo: false,
            showRightAlignment: false,
            showSearchButton: true,
            showSmallButton: false,
            showStrikeThrough: false,
            showSubscript: true,
            showSuperscript: true,
            showUnderLineButton: false,
            showUndo: false,
          ),
        ),
        Expanded(
          child: QuillEditor.basic(
            configurations: QuillEditorConfigurations(
              controller: controller,
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
