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
  List<TempDir> dirs = [];
  @HiveField(4)
  List<TempFile> files = [];

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
