import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../enum/alarm_type.dart';
import '../model/alarm_model.dart';
import '../model/blood_pressure_model.dart';
import '../model/bmi_model.dart';
import '../model/user_model.dart';
import 'hive_constants.dart';

class HiveConfig {
  HiveConfig._();

  static Box<UserModel>? userBox;
  static Box<AlarmModel>? alarmBox;
  static Box<BloodPressureModel>? bloodPressureBox;
  static Box<BMIModel>? bmiBox;

  static Future<void> init() async {
    final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(AlarmModelAdapter());
    Hive.registerAdapter(AlarmTypeAdapter());
    userBox = await Hive.openBox(HiveBox.userBox);
    alarmBox = await Hive.openBox(HiveBox.alarmBox);

    Hive.registerAdapter(BloodPressureModelAdapter());
    bloodPressureBox = await Hive.openBox(HiveBox.bloodPressureBox);

    Hive.registerAdapter(BMIModelAdapter());
    bmiBox = await Hive.openBox(HiveBox.bmiBox);
  }

  void dispose() {
    userBox?.compact();
    alarmBox?.compact();
    bloodPressureBox?.compact();
    bmiBox?.compact();
    Hive.close();
  }
}
