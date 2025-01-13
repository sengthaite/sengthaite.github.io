// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hivedir.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TempDirAdapter extends TypeAdapter<TempDir> {
  @override
  final int typeId = 1;

  @override
  TempDir read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TempDir(
      id: fields[0] as String?,
      createdDate: fields[2] as DateTime?,
      dirname: fields[1] as String,
    )
      ..dirs = (fields[3] as Map).cast<String, TempDir>()
      ..files = (fields[4] as Map).cast<String, TempFile>();
  }

  @override
  void write(BinaryWriter writer, TempDir obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.dirname)
      ..writeByte(2)
      ..write(obj.createdDate)
      ..writeByte(3)
      ..write(obj.dirs)
      ..writeByte(4)
      ..write(obj.files);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TempDirAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TempFileAdapter extends TypeAdapter<TempFile> {
  @override
  final int typeId = 2;

  @override
  TempFile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TempFile(
      id: fields[0] as String?,
      createdDate: fields[2] as DateTime?,
      url: fields[4] as String,
      requestMethod: fields[5] as String,
      filename: fields[1] as String,
    )..fileContent = fields[3] as Uint8List;
  }

  @override
  void write(BinaryWriter writer, TempFile obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.filename)
      ..writeByte(2)
      ..write(obj.createdDate)
      ..writeByte(3)
      ..write(obj.fileContent)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.requestMethod);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TempFileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
