// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodPressureModelAdapter extends TypeAdapter<BloodPressureModel> {
  @override
  final int typeId = 3;

  @override
  BloodPressureModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodPressureModel(
      key: fields[0] as String?,
      systolic: fields[1] as int?,
      diastolic: fields[2] as int?,
      pulse: fields[3] as int?,
      type: fields[4] as int?,
      dateTime: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BloodPressureModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.systolic)
      ..writeByte(2)
      ..write(obj.diastolic)
      ..writeByte(3)
      ..write(obj.pulse)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodPressureModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
