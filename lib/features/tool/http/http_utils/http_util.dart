import 'package:flutter/material.dart';
import 'package:sengthaite_blog/features/navigation/navigation.dart';
import 'package:sengthaite_blog/features/tool/http/http_filename_dialog.dart';

class HttpUtil {
  static void download(List<int> bytes) {
    showDialog<void>(
      context: Navigation().context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) => HttpFilenameDialogWidget(bytes: bytes),
    );
  }

  static void downloadStream(Stream<int> streamBytes) async {
    List<int> bytes = await streamBytes.toList();
    download(bytes);
  }
}
