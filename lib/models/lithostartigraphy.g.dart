// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Lithostartigraphy.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LithostratigraphyModelAdapter
    extends TypeAdapter<LithostratigraphyModel> {
  @override
  final int typeId = 0;

  @override
  LithostratigraphyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LithostratigraphyModel(
      userId: fields[0] as String,
      country: fields[1] as String,
      name: fields[2] as String,
      lithologyMain: fields[3] as String,
      lithologySecondary: fields[4] as String,
      color: fields[5] as String,
      grainSize: fields[6] as String,
      grainShape: fields[7] as String,
      sorting: fields[8] as String,
      minerals: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LithostratigraphyModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.country)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.lithologyMain)
      ..writeByte(4)
      ..write(obj.lithologySecondary)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.grainSize)
      ..writeByte(7)
      ..write(obj.grainShape)
      ..writeByte(8)
      ..write(obj.sorting)
      ..writeByte(9)
      ..write(obj.minerals);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LithostratigraphyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
