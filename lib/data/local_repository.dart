import '../common/config/app_config.dart';
import '../common/config/hive_config/hive_config.dart';
import '../common/config/hive_config/hive_constants.dart';
import '../common/util/app_util.dart';
import '../common/util/share_preference_utils.dart';
import '../domain/model/alarm_model.dart';
import '../domain/model/blood_pressure_model.dart';
import '../domain/model/bmi_model.dart';
import '../domain/model/user_model.dart';

class LocalRepository {
  final HiveConfig _hiveConfig;
  final SharePreferenceUtils _sharePreferenceUtils;

  LocalRepository(this._hiveConfig, this._sharePreferenceUtils);

  Future saveUser(UserModel user) async {
    _hiveConfig.userBox.put(HiveKey.userModel, user);
  }

  UserModel? getUser() {
    return _hiveConfig.userBox.get(HiveKey.userModel);
  }

  List<AlarmModel> getAlarms() {
    return _hiveConfig.alarmBox.values.toList();
  }

  Future<void> removeAlarm(AlarmModel alarmModel) {
    final alarmList = _hiveConfig.alarmBox.values.toList();
    final index = alarmList.indexWhere((element) => element.id == alarmModel.id);
    return _hiveConfig.alarmBox.deleteAt(index);
  }

  Future<void> addAlarm(AlarmModel alarmModel) {
    return _hiveConfig.alarmBox.add(alarmModel);
  }

  Future<void> updateAlarm(AlarmModel alarmModel) {
    final alarmList = _hiveConfig.alarmBox.values.toList();
    final index = alarmList.indexWhere((element) => element.id == alarmModel.id);
    return _hiveConfig.alarmBox.putAt(index, alarmModel);
  }

  Future saveBloodPressure(BloodPressureModel bloodPressureModel) async {
    return await _hiveConfig.bloodPressureBox.put(bloodPressureModel.key, bloodPressureModel);
  }

  Future deleteBloodPressure(String key) async {
    await _hiveConfig.bloodPressureBox.delete(key);
  }

  List<BloodPressureModel> getAll() {
    return _hiveConfig.bloodPressureBox.values.toList();
  }

  List<BloodPressureModel> filterBloodPressureDate(int start, int end) {
    return _hiveConfig.bloodPressureBox.values
        .where((bloodPress) => bloodPress.dateTime! >= start && bloodPress.dateTime! <= end)
        .toList();
  }

  Future saveBMIModel(BMIModel bmi) async {
    await _hiveConfig.bmiBox.put(bmi.key, bmi);
  }

  List<BMIModel> filterBMI(int start, int end) {
    return _hiveConfig.bmiBox.values.where((bmi) => bmi.dateTime! >= start && bmi.dateTime! <= end).toList();
  }

  List<BMIModel> getAllBMI() => _hiveConfig.bmiBox.values.toList();

  Future<bool> setWeightUnitId(int id) => _sharePreferenceUtils.setInt(AppConfig.weightUnitIdKey, id);

  int? getWeightUnitId() => _sharePreferenceUtils.getInt(AppConfig.weightUnitIdKey);

  Future<bool> setHeightUnitId(int id) => _sharePreferenceUtils.setInt(AppConfig.heightUnitIdKey, id);

  int? getHeightUnitId() => _sharePreferenceUtils.getInt(AppConfig.heightUnitIdKey);

  Future updateBMI(BMIModel bmi) async {
    await _hiveConfig.bmiBox.put(bmi.key, bmi);
  }

  Future deleteBMI(String key) async {
    await _hiveConfig.bmiBox.delete(key);
  }

  Future<bool> setFreeAdCount(int value) async {
    return _sharePreferenceUtils.setInt("freeAdCount", value);
  }

  Future<bool> getAllowHeartRateFirstTime() async {
    return _sharePreferenceUtils.getBool("allowHeartRateFirstTime") ?? true;
  }

  Future<bool> getAllowBloodPressureFirstTime() async {
    return _sharePreferenceUtils.getBool("allowBloodPressureFirstTime") ?? true;
  }

  Future<bool> getAllowBloodSugarFirstTime() async {
    return _sharePreferenceUtils.getBool("allowBloodSugarFirstTime") ?? true;
  }

  Future<bool> getAllowWeightAndBMIFirstTime() async {
    return _sharePreferenceUtils.getBool("allowWeightAndBMIFirstTime") ?? true;
  }

  Future<bool> setAllowHeartRateFirstTime(bool value) async {
    return _sharePreferenceUtils.setBool("allowHeartRateFirstTime", value);
  }

  Future<bool> setAllowBloodPressureFirstTime(bool value) {
    return _sharePreferenceUtils.setBool("allowBloodPressureFirstTime", value);
  }

  Future<bool> setAllowBloodSugarFirstTime(bool value) {
    return _sharePreferenceUtils.setBool("allowBloodSugarFirstTime", value);
  }

  Future<bool> setAllowWeightAndBMIFirstTime(bool value) {
    return _sharePreferenceUtils.setBool("allowWeightAndBMIFirstTime", value);
  }

  /// [IOS] Set lan dau mo app
  Future<bool> setFirstTimeOpenApp(int dateTime) => _sharePreferenceUtils.setInt(AppConfig.firstTimeOpenApp, dateTime);

  int? getFirstTimeOpenApp() => _sharePreferenceUtils.getInt(AppConfig.firstTimeOpenApp);
}
