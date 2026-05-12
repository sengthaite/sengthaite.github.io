import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive_ce/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sengthaite_blog/constants/app.constants.dart';
import 'package:sengthaite_blog/shared/file/hiveeditor.dart';

class TextEditorTool extends StatefulWidget {
  const TextEditorTool({super.key, required this.initQuillController});

  final ValueNotifier<QuillController> initQuillController;

  @override
  State<TextEditorTool> createState() => _TextEditorToolState();
}

class _TextEditorToolState extends State<TextEditorTool> {
  final _hiveSubject = PublishSubject<Document>();
  QuillController? controller;

  Future<Box<HiveEditor>> get _box async =>
      await Hive.openBox<HiveEditor>(hiveEditor);

  Future<void> saveOnChanged(Document document) async {
    final box = await _box;
    final hiveEditor = HiveEditor();
    box.put("content", hiveEditor);
    debugPrint("Saved markdown: ${document.toPlainText()}");
    hiveEditor.saveData(document.toDelta());
  }

  Future<void> loadMarkdown() async {
    try {
      final box = await _box;
      final hiveBox = box.get("content");
      if (hiveBox == null) return;
      final data = hiveBox.formatDelta(hiveBox.data);
      if (data != null) {
        var doc = Document.fromDelta(data);
        controller = QuillController(
          document: doc,
          selection: TextSelection.fromPosition(
            TextPosition(offset: doc.length > 0 ? doc.length - 1 : 0),
          ),
        );
      } else {
        controller = QuillController.basic();
      }
      widget.initQuillController.value = controller!;
      controller!.changes
          .debounceTime(const Duration(milliseconds: 100))
          .listen((document) async => await saveOnChanged(controller!.document));
    } catch (error) {
      debugPrint("load markdown: ${error.toString()}");
    }
  }

  @override
  initState() {
    loadMarkdown();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    debugPrint("dispose class ${runtimeType.toString()}");
    _hiveSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.initQuillController,
      builder: (context, controller, widget) {
        return Column(
          children: [
            Expanded(child: QuillEditor.basic(controller: controller)),
          ],
        );
      },
    );
  }
}
