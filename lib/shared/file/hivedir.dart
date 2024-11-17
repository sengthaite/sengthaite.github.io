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

  Future<void> addNewFile(String filename) async =>
      files[filename] = TempFile(filename: filename);

  Future<void> removeFileName(String filename) async => files.remove(filename);

  TempDir({
    String? id,
    DateTime? createdDate,
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

  TempFile({
    String? id,
    DateTime? createdDate,
    required this.filename,
  })  : id = id ?? const Uuid().v4(),
        createdDate = createdDate ?? DateTime.now();
}
