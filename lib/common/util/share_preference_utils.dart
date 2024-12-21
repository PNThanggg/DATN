import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceUtils {
  late SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences =
        await SharedPreferences.getInstance();
  }

  Future<bool> setString(String key, String value) =>
      _sharedPreferences.setString(key, value);

  String? getString(String key) =>
      _sharedPreferences.getString(key);

  Future<bool> setInt(String key, int value) =>
      _sharedPreferences.setInt(key, value);

  int? getInt(String key) => _sharedPreferences.getInt(key);

  bool? getBool(String key) => _sharedPreferences.getBool(key);

  Future<bool> setBool(String key, bool value) {
    return _sharedPreferences.setBool(key, value);
  }
}
