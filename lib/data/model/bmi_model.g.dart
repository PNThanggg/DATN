// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bmi_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BMIModelAdapter extends TypeAdapter<BMIModel> {
  @override
  final int typeId = 5;

  @override
  BMIModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++)
        reader.readByte(): reader.read(),
    };
    return BMIModel(
      key: fields[0] as String?,
      weight: fields[1] as double?,
      weightUnitId: fields[2] as int?,
      typeId: fields[3] as int?,
      dateTime: fields[4] as int?,
      age: fields[5] as int?,
      height: fields[6] as double?,
      heightUnitId: fields[7] as int?,
      gender: fields[8] as String?,
      bmi: fields[9] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BMIModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.weight)
      ..writeByte(2)
      ..write(obj.weightUnitId)
      ..writeByte(3)
      ..write(obj.typeId)
      ..writeByte(4)
      ..write(obj.dateTime)
      ..writeByte(5)
      ..write(obj.age)
      ..writeByte(6)
      ..write(obj.height)
      ..writeByte(7)
      ..write(obj.heightUnitId)
      ..writeByte(8)
      ..write(obj.gender)
      ..writeByte(9)
      ..write(obj.bmi);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BMIModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
