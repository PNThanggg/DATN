import 'package:shared_preferences/shared_preferences.dart';

import 'app_log.dart';
import 'share_preference_key.dart';

abstract class SharePreferenceUtils {
  static SharedPreferences? _instance;

  static SharedPreferences get instance => _instance!;

  static Future<void> init() async {
    AppLog.info("SharedPreferences::init");

    _instance ??= await SharedPreferences.getInstance();
  }

  static String? getString(String key) => instance.getString(key);

  static Future<void> setStringKey(
    String key,
    String value,
  ) {
    return instance.setString(key, value);
  }

  static int? getIntOrNull(
    String key,
  ) =>
      instance.getInt(key);

  static bool getBool(
    String key,
  ) =>
      instance.getBool(key) ?? false;

  static bool? getBoolOrNull(
    String key,
  ) =>
      instance.getBool(key);

  static Future<void> setInt(
    String key,
    int value,
  ) =>
      instance.setInt(key, value);

  static Future<void> setBool(
    String key,
    bool value,
  ) =>
      instance.setBool(key, value);

  static Future<void> clear() => instance.clear();

  static Future<void> removeKey(
    String key,
  ) =>
      instance.remove(key);

  static bool get isFirstOpenApp => getBoolOrNull(SharePreferenceKey.firstOpenApp) ?? true;

  static void setFirstOpenApp() => setBool(SharePreferenceKey.firstOpenApp, false);
}
