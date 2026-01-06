// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appsetting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppSettingsAdapter extends TypeAdapter<AppSettings> {
  @override
  final typeId = 3;

  @override
  AppSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppSettings(
        id: fields[0] as String?,
        createdDate: fields[1] as DateTime?,
        isFullScreenMode: fields[2] as bool?,
      )
      ..localeLanguageCode = fields[3] as String?
      ..localeCountryCode = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdDate)
      ..writeByte(2)
      ..write(obj.isFullScreenMode)
      ..writeByte(3)
      ..write(obj.localeLanguageCode)
      ..writeByte(4)
      ..write(obj.localeCountryCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
