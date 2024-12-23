// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlarmTypeAdapter extends TypeAdapter<AlarmType> {
  @override
  final int typeId = 4;

  @override
  AlarmType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AlarmType.heartRate;
      case 1:
        return AlarmType.bloodPressure;
      case 2:
        return AlarmType.weightAndBMI;
      default:
        return AlarmType.heartRate;
    }
  }

  @override
  void write(BinaryWriter writer, AlarmType obj) {
    switch (obj) {
      case AlarmType.heartRate:
        writer.writeByte(0);
        break;
      case AlarmType.bloodPressure:
        writer.writeByte(1);
        break;
      case AlarmType.weightAndBMI:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is AlarmTypeAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
