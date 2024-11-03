import 'package:hive/hive.dart';

import '../enum/alarm_type.dart';
import '../hive_config/hive_constants.dart';

part 'alarm_model.g.dart';


@HiveType(typeId: HiveTypeConstants.alarmModel)
class AlarmModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final AlarmType type;
  @HiveField(2)
  final DateTime time;
  @HiveField(3)
  final List<bool>? alarmDays;

  const AlarmModel({
    required this.id,
    this.type = AlarmType.bloodPressure,
    required this.time,
    required this.alarmDays,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "alarmType": type,
      "timeOfDay": time,
      "alarmDays": alarmDays,
    };
  }

  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
        id: json["id"] as String?,
        type: AlarmType.values
            .firstWhere((e) => e.toString() == json["alarmType"]),
        time: DateTime.parse(json["time"] as String? ?? DateTime.now().toIso8601String()),
        alarmDays: json["alarmDays"] as List<bool>?);
  }

  AlarmModel copyWith({
    String? id,
    AlarmType? type,
    DateTime? time,
    List<bool>? alarmDays,
  }) {
    return AlarmModel(
        id: id ?? this.id,
        type: type ?? this.type,
        time: time ?? this.time,
      alarmDays: alarmDays ?? this.alarmDays,
    );
  }
}
