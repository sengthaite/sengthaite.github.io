import 'package:flutter/material.dart';
import 'package:sengthaite_blog/features/navigation/navigation.dart';
import 'package:sengthaite_blog/features/tool/api/api_filename_dialog.dart';

class APIUtil {
  static void download(List<int> bytes) {
    showDialog<void>(
      context: Navigation().context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) => APIFilenameDialogWidget(bytes: bytes),
    );
  }

  static void downloadStream(Stream<int> streamBytes) async {
    List<int> bytes = await streamBytes.toList();
    download(bytes);
  }
}
