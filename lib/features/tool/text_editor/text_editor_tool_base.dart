import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive_ce/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sengthaite_blog/features/tool/text_editor/text_editor_toolbar_view.dart';
import 'package:sengthaite_blog/shared/app.data.dart';
import 'package:sengthaite_blog/shared/data/file/hiveeditor.dart';

class TextEditorTool extends StatefulWidget {
  const TextEditorTool({
    super.key,
    required this.initQuillController,
    this.showBottomToolbar = false,
  });

  final ValueNotifier<QuillController> initQuillController;
  final bool showBottomToolbar;

  @override
  State<TextEditorTool> createState() => _TextEditorToolState();
}

class _TextEditorToolState extends State<TextEditorTool> {
  final _hiveSubject = PublishSubject<Document>();
  final hiveEditor = HiveEditor();
  QuillController? controller;

  Future<void> loadMarkdown() async {
    try {
      if (await AppData().initTextEditorData() == false) {
        throw HiveError("initTextEditorData() failed");
      }
      final box = AppData().textEditor;
      if (box != null) {
        final data = box.formatDelta();
        if (data != null) {
          var doc = Document.fromDelta(data);
          controller = QuillController(
            document: doc,
            selection: TextSelection.fromPosition(
              TextPosition(offset: doc.length > 0 ? doc.length - 1 : 0),
            ),
          );
        }
      }
      controller ??= QuillController.basic();
      widget.initQuillController.value = controller!;
      controller!.changes
          .debounceTime(const Duration(milliseconds: 100))
          .listen((document) async {
            var content = '';
            var deltaContent = controller?.document;
            if (deltaContent != null) {
              content = jsonEncode(deltaContent.toDelta().toJson());
            }
            AppData().textEditor?.data = content;
            await AppData().saveEditorContent();
          });
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
    var showBottomToolbar = widget.showBottomToolbar;
    return ValueListenableBuilder(
      valueListenable: widget.initQuillController,
      builder: (context, controller, widget) {
        return Column(
          children: [
            Expanded(child: QuillEditor.basic(controller: controller)),
            if (showBottomToolbar)
              Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                  right: 4,
                  top: 4,
                  bottom: 8,
                ),
                child: TextEditorToolbarView(controller: controller),
              ),
          ],
        );
      },
    );
  }
}
