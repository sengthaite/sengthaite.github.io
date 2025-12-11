// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveeditor.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveEditorAdapter extends TypeAdapter<HiveEditor> {
  @override
  final typeId = 4;

  @override
  HiveEditor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveEditor(content: fields[0] as String);
  }

  @override
  void write(BinaryWriter writer, HiveEditor obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveEditorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
