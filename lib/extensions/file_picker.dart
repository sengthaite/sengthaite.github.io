import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

Future<String?> openFilePicker() async {
  {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final fileContent = await result.files.single.xFile.readAsString();
      return fileContent;
    } else {
      // User canceled the picker
      debugPrint("User cancel file picker");
    }
  }
  return null;
}
