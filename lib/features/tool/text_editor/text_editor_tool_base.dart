
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive_ce/hive.dart';
import 'package:sengthaite_blog/shared/file/hiveeditor.dart';

class TextEditorTool extends StatefulWidget {
  const TextEditorTool({super.key, required this.widget});

  final Widget widget;

  @override
  State<TextEditorTool> createState() => _TextEditorToolState();
}


class _TextEditorToolState extends State<TextEditorTool> {
  final _hiveEditor = "hive_editor";
  final QuillController controller = QuillController.basic();

  Future<Box<HiveEditor>> get _box async =>
      await Hive.openBox<HiveEditor>(_hiveEditor);

  Future<void> saveAsMarkdown() async {
    final box = await _box;
    final document = controller.document;
    final hiveEditor = HiveEditor();
    box.put("content", hiveEditor);
    hiveEditor.saveData(document.toDelta());
  }

  Future<void> loadMarkdown() async {
    try {
      final box = await _box;
      final hiveBox = box.get("content");
      if (hiveBox == null) return;
      final data = hiveBox.formatDelta(hiveBox.data);
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
    loadMarkdown();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await saveAsMarkdown();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.widget;
  }
}
