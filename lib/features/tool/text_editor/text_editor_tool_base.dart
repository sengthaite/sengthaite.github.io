import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive_ce/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sengthaite_blog/shared/file/hiveeditor.dart';

class TextEditorTool extends StatefulWidget {
  const TextEditorTool({
    super.key,
    required this.config,
    required this.controller,
  });

  final QuillEditorConfig config;
  final QuillController controller;

  @override
  State<TextEditorTool> createState() => _TextEditorToolState();
}

class _TextEditorToolState extends State<TextEditorTool> {
  final _hiveEditor = "hive_editor";
  final _hiveSubject = PublishSubject<Document>();
  StreamSubscription? _subscription;

  Future<Box<HiveEditor>> get _box async =>
      await Hive.openBox<HiveEditor>(_hiveEditor);

  Future<void> saveAsMarkdown(Document document) async {
    final box = await _box;
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
        widget.controller.document = Document.fromDelta(data);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void _documentListener() {
    _hiveSubject.add(widget.controller.document);
  }

  @override
  void initState() {
    super.initState();
    loadMarkdown();
    _subscription = _hiveSubject
        .debounceTime(const Duration(milliseconds: 500))
        .listen((document) async => await saveAsMarkdown(document));

    widget.controller.removeListener(_documentListener);
    widget.controller.addListener(_documentListener);
  }

  @override
  Future<void> dispose() async {
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
            controller: widget.controller,
            config: widget.config,
          ),
        ),
      ],
    );
  }
}
