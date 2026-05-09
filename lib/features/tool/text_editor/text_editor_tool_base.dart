import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive_ce/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sengthaite_blog/constants/app.constants.dart';
import 'package:sengthaite_blog/shared/file/hiveeditor.dart';

class TextEditorTool extends StatefulWidget {
  const TextEditorTool({super.key, required this.config, this.onInit});

  final QuillEditorConfig config;
  final void Function(QuillController)? onInit;

  @override
  State<TextEditorTool> createState() => _TextEditorToolState();
}

class _TextEditorToolState extends State<TextEditorTool> {
  final _hiveSubject = PublishSubject<Document>();
  final quillController = QuillController.basic();
  StreamSubscription? _subscription;

  Future<Box<HiveEditor>> get _box async =>
      await Hive.openBox<HiveEditor>(hiveEditor);

  Future<void> saveAsMarkdown(Document document) async {
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
        quillController.document = Document.fromDelta(data);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void _documentListener() {
    _hiveSubject.add(quillController.document);
  }

  @override
  void initState() {
    widget.onInit?.call(quillController);
    loadMarkdown();
    _subscription = _hiveSubject
        .debounceTime(const Duration(milliseconds: 100))
        .listen((document) async => await saveAsMarkdown(document));

    quillController.addListener(_documentListener);
    super.initState();
  }

  @override
  Future<void> dispose() async {
    quillController.removeListener(_documentListener);
    quillController.dispose();
    _subscription?.cancel();
    _hiveSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: QuillEditor.basic(
            controller: quillController,
            config: widget.config,
          ),
        ),
      ],
    );
  }
}
