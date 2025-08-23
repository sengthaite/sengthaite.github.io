import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:sengthaite_blog/constants/theme.dart';
import 'package:sengthaite_blog/features/navigation/navigation.dart';
import 'package:sengthaite_blog/features/tool/api/api_filename_dialog.dart';

class APIUtil {
  static void showTextDialog(String text) {
    showDialog<void>(
      context: Navigation().context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel",
                  style: TextStyle(
                    color: MaterialTheme.colorScheme(context).secondary,
                  )),
            ),
          ],
        );
      },
    );
  }

  static void download(Uint8List bytes) {
    showDialog<void>(
      context: Navigation().context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) => APIFilenameDialogWidget(bytes: bytes),
    );
  }

  static void downloadStream(Stream<int> streamBytes) async {
    List<int> bytes = await streamBytes.toList();
    download(Uint8List.fromList(bytes));
  }
}
