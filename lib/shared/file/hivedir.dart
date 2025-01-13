import 'dart:convert';
import 'dart:typed_data';

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'hivedir.g.dart';

@HiveType(typeId: 1)
class TempDir {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String dirname;
  @HiveField(2)
  final DateTime createdDate;
  @HiveField(3)
  Map<String, TempDir> dirs = {};
  @HiveField(4)
  Map<String, TempFile> files = {};

  List<TempFile> get fileList => files.values.toList();

  List<TempDir> get dirList => dirs.values.toList();

  Future<TempFile?> getFile(String filename) async => files[filename];

  Future<void> setFileContent(String filename, Uint8List data) async =>
      files[filename]?.fileContent = data;

  Future<void> addNewFile(String filename, TempFile file) async {
    files[filename] = file;
    if (onFileListChange != null) {
      onFileListChange!();
    }
  }

  Future<void> removeFileName(String filename) async {
    files.remove(filename);
    if (onFileListChange != null) {
      onFileListChange!();
    }
  }

  Future<void> removeFileNameByIndex(List<String> filenames) async {
    for (var name in filenames) {
      files.remove(name);
    }
    if (onFileListChange != null) {
      onFileListChange!();
    }
  }

  Future<void> clean() async {
    files = {};
    if (onFileListChange != null) {
      onFileListChange!();
    }
  }

  Function? onFileListChange;

  TempDir({
    String? id,
    DateTime? createdDate,
    this.onFileListChange,
    required this.dirname,
  })  : id = id ?? const Uuid().v4(),
        createdDate = createdDate ?? DateTime.now();
}

@HiveType(typeId: 2)
class TempFile {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String filename;
  @HiveField(2)
  final DateTime createdDate;
  @HiveField(3)
  Uint8List fileContent = Uint8List.fromList([]);

  get getFileContentJson => jsonDecode(String.fromCharCodes(fileContent));

  set newFileContent(String content) =>
      fileContent = Uint8List.fromList(content.codeUnits);

  @HiveField(4)
  final String url;
  @HiveField(5)
  final String requestMethod;

  TempFile({
    String? id,
    DateTime? createdDate,
    required this.url,
    required this.requestMethod,
    required this.filename,
  })  : id = id ?? const Uuid().v4(),
        createdDate = createdDate ?? DateTime.now();
}
