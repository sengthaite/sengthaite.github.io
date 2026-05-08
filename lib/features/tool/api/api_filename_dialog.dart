import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/theme.dart';

class APIFilenameDialogWidget extends StatefulWidget {
  final Uint8List bytes;

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
  var textTheme = MaterialTheme.textTheme();

  void download() async {
    await FileSaver.instance.saveFile(
      name: downloadName.isEmpty ? 'download' : downloadName,
      bytes: widget.bytes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
             Text(
              'Download',
              style: textTheme.bodyMedium!.copyWith(
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
