import 'dart:async';
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive_ce/hive.dart';
import 'package:path/path.dart' as path;
import 'package:rxdart/rxdart.dart';
import 'package:sengthaite_blog/constants/app.constants.dart';
import 'package:sengthaite_blog/shared/file/hiveeditor.dart';

class TextEditorTool extends StatefulWidget {
  const TextEditorTool({super.key, required this.config});

  final QuillEditorConfig config;

  static QuillController? quillController;

  @override
  State<TextEditorTool> createState() => _TextEditorToolState();
}

class _TextEditorToolState extends State<TextEditorTool> {
  final _hiveSubject = PublishSubject<Document>();
  StreamSubscription? _subscription;

  Future<Box<HiveEditor>> get _box async =>
      await Hive.openBox<HiveEditor>(hiveEditor);

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
        TextEditorTool.quillController?.document = Document.fromDelta(data);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void _documentListener() {
    _hiveSubject.add(TextEditorTool.quillController!.document);
  }

  @override
  void initState() {
    TextEditorTool.quillController = QuillController.basic(
      config: QuillControllerConfig(
        clipboardConfig: QuillClipboardConfig(
          enableExternalRichPaste: true,
          onImagePaste: (imageBytes) async {
            if (kIsWeb) {
              return null;
            }
            final newFileName =
                'image-file-${DateTime.now().toIso8601String()}.png';
            final newPath = path.join(
              io.Directory.systemTemp.path,
              newFileName,
            );
            final file = await io.File(
              newPath,
            ).writeAsBytes(imageBytes, flush: true);
            return file.path;
          },
        ),
      ),
    );
    loadMarkdown();
    _subscription = _hiveSubject
        .debounceTime(const Duration(milliseconds: 100))
        .listen((document) async => await saveAsMarkdown(document));

    TextEditorTool.quillController!.addListener(_documentListener);
    super.initState();
  }

  @override
  Future<void> dispose() async {
    TextEditorTool.quillController?.removeListener(_documentListener);
    TextEditorTool.quillController?.dispose();
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
            controller: TextEditorTool.quillController!,
            config: widget.config,
          ),
        ),
      ],
    );
  }
}
