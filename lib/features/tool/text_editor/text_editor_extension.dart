import 'dart:convert';
import 'dart:io';
import 'package:file_saver/file_saver.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_to_pdf/flutter_quill_to_pdf.dart';
import 'package:markdown_quill/markdown_quill.dart';
import 'package:path/path.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

extension TextEditorExt on QuillController {
  Future<void> saveMarkdown() async {
    var delta = document.toDelta();
    var markdown = DeltaToMarkdown().convert(delta);
    await saveFile(Uint8List.fromList(utf8.encode(markdown)), ext: 'md');
  }

  Future<void> saveHTML() async {
    var delta = document.toDelta();
    String html = QuillDeltaToHtmlConverter(
      List.castFrom(delta.toJson()),
      ConverterOptions.forEmail(),
    ).convert();
    await saveFile(Uint8List.fromList(utf8.encode(html)), ext: 'html');
  }

  Future<void> saveFile(Uint8List doc, {required String ext}) async {
    final fileName = 'note_${DateTime.now().millisecondsSinceEpoch}';
    await FileSaver.instance.saveFile(
      name: fileName,
      bytes: doc,
      fileExtension: ext,
    );
  }

  Future<void> savePDF() async {
    final PDFPageFormat params = PDFPageFormat.a4;
    bool isAndroid = false;
    bool isMacOriOS = false;
    try {
      isAndroid = Platform.isAndroid;
    } catch (error) {
      debugPrint(error.toString());
    }
    try {
      isMacOriOS = Platform.isMacOS || Platform.isIOS;
    } catch (error) {
      debugPrint(error.toString());
    }
    final fileName = 'note_${DateTime.now().millisecondsSinceEpoch}';
    final Object? result = isAndroid
        ? await getDirectoryPath(confirmButtonText: 'Select directory')
        : await getSaveLocation(
            suggestedName: fileName,
            acceptedTypeGroups: [
              XTypeGroup(
                label: 'Pdf',
                extensions: ['pdf'],
                mimeTypes: ['application/pdf'],
                uniformTypeIdentifiers: ['com.adobe.pdf'],
              ),
            ],
          );
    if (result == null) {
      debugPrint("Cannot get path to save the file");
      return;
    }
    PDFConverter pdfConverter = PDFConverter(
      fallbacks: [],
      document: document.toDelta(),
      pageFormat: params,
    );
    final pdfDoc = await pdfConverter.createDocument();
    if (pdfDoc == null) {
      return;
    }
    final String name =
        'document_${DateTime.now().millisecondsSinceEpoch.toString()}.pdf';
    final XFile textFile = XFile.fromData(
      await pdfDoc.save(),
      mimeType: isAndroid
          ? 'application/pdf'
          : isMacOriOS
          ? (result as FileSaveLocation)
                    .activeFilter
                    ?.uniformTypeIdentifiers
                    ?.single ??
                'com.adobe.pdf'
          : (result as FileSaveLocation).activeFilter?.mimeTypes?.single ??
                'application/pdf',
      name: name,
    );
    await textFile.saveTo(
      isAndroid
          ? join(result as String, name)
          : (result as FileSaveLocation).path,
    );
  }
}
