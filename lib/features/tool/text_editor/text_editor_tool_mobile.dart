import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive_ce/hive.dart';
import 'package:sengthaite_blog/shared/file/hiveeditor.dart';

class TextEditorToolMobile extends StatefulWidget {
  const TextEditorToolMobile({super.key});

  @override
  State<TextEditorToolMobile> createState() => _TextEditorToolMobileState();
}

class _TextEditorToolMobileState extends State<TextEditorToolMobile> {
  final _hiveEditor = "HIVE_EDITOR_CONTENT";
  final QuillController controller = QuillController.basic();

  Future<Box<HiveEditor>> get _box async =>
      await Hive.openBox<HiveEditor>(_hiveEditor);

  Future<void> saveAsMarkdown() async {
    final document = controller.document;
    // final markdown = HiveList(objects: document.toDelta().toJson());
    // final box = await _box;
    // box.put("content", HiveEditor(content: markdown));
  }

  Future<void> loadMarkdown() async {
    // final box = await _box;
    // try {
    //   final json = box.get("content");
    //   if (json != null) controller.document = Document.fromJson(json.content);
    // } catch (error) {
    //   box.deleteFromDisk();
    //   debugPrint(error.toString());
    // }
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: QuillEditor.basic(
            controller: controller,
            config: QuillEditorConfig(),
          ),
        ),
      ],
    );
  }
}
