import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class APIFilenameDialogWidget extends StatefulWidget {
  final List<int> bytes;

  const APIFilenameDialogWidget({
    super.key,
    required this.bytes,
  });
  @override
  State<APIFilenameDialogWidget> createState() =>
      _APIFilenameDialogWidgetState();
}

class _APIFilenameDialogWidgetState extends State<APIFilenameDialogWidget> {
  String downloadName = '';

  void download() {
    // Encode our file in base64
    final base64 = base64Encode(widget.bytes);
    // Create the link with the file
    final anchor =
        html.AnchorElement(href: 'data:application/octet-stream;base64,$base64')
          ..target = 'blank';
    // add the name
    anchor.download = downloadName;
    // trigger download
    html.document.body?.append(anchor);
    anchor.click();
    anchor.remove();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            const Text(
              'Download',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                hintTextDirection: TextDirection.ltr,
                labelText: "Filename",
                hintText: "Input file name",
              ),
              autovalidateMode: AutovalidateMode.onUnfocus,
              onChanged: (value) {
                setState(() {
                  downloadName = value;
                });
              },
              onFieldSubmitted: (value) {
                downloadName = value;
                download();
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: downloadName.isEmpty ? null : download,
          child: const Text('Download'),
        ),
      ],
    );
  }
}
