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
      ..githubToken = fields[4] as String?
      ..githubUrl = fields[5] as String?
      ..rememberedMe = fields[6] as bool?
      ..themeMode = fields[7] as String?;
  }

  @override
  void write(BinaryWriter writer, AppSettings obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdDate)
      ..writeByte(2)
      ..write(obj.isFullScreenMode)
      ..writeByte(3)
      ..write(obj.localeLanguageCode)
      ..writeByte(4)
      ..write(obj.githubToken)
      ..writeByte(5)
      ..write(obj.githubUrl)
      ..writeByte(6)
      ..write(obj.rememberedMe)
      ..writeByte(7)
      ..write(obj.themeMode);
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
