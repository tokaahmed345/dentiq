// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalScanModelAdapter extends TypeAdapter<LocalScanModel> {
  @override
  final int typeId = 0;

  @override
  LocalScanModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalScanModel(
      label: fields[0] as String,
      confidence: fields[1] as double,
      imagePath: fields[2] as String,
      date: fields[3] as DateTime,
      isSynced: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LocalScanModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.confidence)
      ..writeByte(2)
      ..write(obj.imagePath)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.isSynced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalScanModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
