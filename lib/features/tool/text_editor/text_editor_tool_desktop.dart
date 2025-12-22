import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:hive_ce/hive.dart';
import 'package:sengthaite_blog/shared/file/hiveeditor.dart';

class TextEditorToolDesktop extends StatefulWidget {
  const TextEditorToolDesktop({super.key});

  @override
  State<TextEditorToolDesktop> createState() => _TextEditorToolDesktopState();
}

class _TextEditorToolDesktopState extends State<TextEditorToolDesktop> {
  final _hiveEditor = "HIVE_EDITOR_CONTENT";
  final QuillController controller = QuillController.basic();

  Future<Box<HiveEditor>> get _box async =>
      await Hive.openBox<HiveEditor>(_hiveEditor);

  Future<void> saveAsMarkdown() async {
    final box = await _box;
    final document = controller.document;
    final hiveEditor = HiveEditor();
    hiveEditor.putData = document.toDelta();
    box.put("content", hiveEditor);
  }

  Future<void> loadMarkdown() async {
    try {
      final box = await _box;
      final data = box.get("content")?.getData;
      if (data != null) {
        controller.document = Document.fromDelta(data);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    Hive.init(_hiveEditor);
    loadMarkdown();
    controller.addListener(saveAsMarkdown);
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(saveAsMarkdown);
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: QuillEditor.basic(
            controller: controller,
            config: QuillEditorConfig(minHeight: 300),
          ),
        ),
      ],
    );
  }
}
