import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/config/hive_config/hive_config.dart';
import '../../common/constants/app_constant.dart';
import '../../common/injector/app_di.dart';
import '../../data/local_repository.dart';
import '../../domain/model/heart_rate_model.dart';
import '../../domain/model/user_model.dart';

onSelectNotification(s1) async {}

class AppController extends SuperController {
  Locale currentLocale = AppConstant.availableLocales[1];
  Rx<UserModel> currentUser = UserModel().obs;
  final _localRepository = getIt.get<LocalRepository>();

  RxString userLocation = "US".obs;

  RxBool allowHeartRateFirstTime = false.obs;
  RxBool allowBloodPressureFirstTime = false.obs;
  RxBool allowBloodSugarFirstTime = false.obs;
  RxBool allowWeightAndBMIFirstTime = false.obs;

  bool firstOpenInsight = true;
  bool firstOpenAlarm = true;
  bool firstPressBloodPressure = true;
  bool firstPressMeasureNow = true;

  RxList<Map> chartListData = RxList();
  RxList<HeartRateModel> listHeartRateModel = RxList();
  List<HeartRateModel> listHeartRateModelAll = [];

  @override
  void onInit() {
    _setupAllowAd();
    super.onInit();
  }

  void _setupAllowAd() {
    _localRepository.getAllowHeartRateFirstTime().then((value) {
      allowHeartRateFirstTime.value = value;
    });

    _localRepository.getAllowBloodPressureFirstTime().then((value) {
      allowBloodPressureFirstTime.value = value;
    });

    _localRepository.getAllowBloodSugarFirstTime().then((value) {
      allowBloodSugarFirstTime.value = value;
    });

    _localRepository.getAllowWeightAndBMIFirstTime().then((value) {
      allowWeightAndBMIFirstTime.value = value;
    });
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  @override
  void onHidden() {}

  @override
  void onReady() {
    super.onReady();

    _initNotificationSelectHandle();

    // HomeWidget.registerInteractivityCallback(HomeWidgetConfig.backgroundCallback);
  }

  @override
  void onClose() {
    getIt<HiveConfig>().dispose();
    super.onClose();
  }

  void updateLocale(Locale locale) {
    Get.updateLocale(locale);
    currentLocale = locale;
  }

  void updateUser(UserModel userModel) async {
    currentUser.value = userModel;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(userModel.toJson()));
  }

  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? stringUser = prefs.getString('user');
    if ((stringUser ?? '').isNotEmpty) {
      currentUser.value = UserModel.fromJson(jsonDecode(stringUser!));
    }
  }

  _initNotificationSelectHandle() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: onSelectNotification,
    );
  }

  onDidReceiveLocalNotification(i1, s1, s2, s3) {}

  void setAllowHeartRateFirstTime(bool value) {
    allowHeartRateFirstTime.value = value;
    _localRepository.setAllowHeartRateFirstTime(value);
  }

  void setAllowBloodPressureFirstTime(bool value) {
    allowBloodPressureFirstTime.value = value;
    _localRepository.setAllowBloodPressureFirstTime(value);
  }

  void setAllowBloodSugarFirstTime(bool value) {
    allowBloodSugarFirstTime.value = value;
    _localRepository.setAllowBloodSugarFirstTime(value);
  }

  void setAllowWeightAndBMIFirstTime(bool value) {
    allowWeightAndBMIFirstTime.value = value;
    _localRepository.setAllowWeightAndBMIFirstTime(value);
  }
}
