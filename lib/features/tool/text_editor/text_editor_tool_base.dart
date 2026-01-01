import 'dart:async';
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:hive_ce/hive.dart';
import 'package:path/path.dart' as path;
import 'package:rxdart/rxdart.dart';
import 'package:sengthaite_blog/shared/file/hiveeditor.dart';

class TextEditorTool extends StatefulWidget {
  const TextEditorTool({super.key, required this.config});

  final QuillEditorConfig config;

  @override
  State<TextEditorTool> createState() => _TextEditorToolState();
}

class _TextEditorToolState extends State<TextEditorTool> {
  final _hiveEditor = "hive_editor";
  final _hiveSubject = PublishSubject<Document>();
  StreamSubscription? _subscription;
  final QuillController _controller = () {
    return QuillController.basic(
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
  }();

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
        _controller.document = Document.fromDelta(data);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    loadMarkdown();
    _subscription = _hiveSubject
        .debounceTime(const Duration(milliseconds: 500))
        .listen((document) async => await saveAsMarkdown(document));

    _controller.addListener(() => _hiveSubject.add(_controller.document));
  }

  @override
  Future<void> dispose() async {
    _controller.dispose();
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
            controller: _controller,
            config: widget.config,
          ),
        ),
      ],
    );
  }
}
