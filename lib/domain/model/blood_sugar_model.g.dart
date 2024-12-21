// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_sugar_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodSugarModelAdapter extends TypeAdapter<BloodSugarModel> {
  @override
  final int typeId = 6;

  @override
  BloodSugarModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodSugarModel(
      key: fields[0] as String?,
      stateCode: fields[1] as String?,
      measure: fields[2] as double?,
      unit: fields[3] as String?,
      infoCode: fields[4] as String?,
      dateTime: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BloodSugarModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.stateCode)
      ..writeByte(2)
      ..write(obj.measure)
      ..writeByte(3)
      ..write(obj.unit)
      ..writeByte(4)
      ..write(obj.infoCode)
      ..writeByte(5)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodSugarModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
