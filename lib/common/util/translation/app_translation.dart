import 'package:get/get.dart';

import 'en_strings.dart';
import 'vi_strings.dart';

class AppTranslation extends Translations {
  static const String localeCodeVi = 'vi_VN';
  static const String localeCodeEn = 'en_US';

  @override
  Map<String, Map<String, String>> get keys => {
        localeCodeVi: viStrings,
        localeCodeEn: enStrings,
      };

  static String getString(String key) {
    Map<String, String> selectedLanguage = Get.locale.toString() == localeCodeEn ? enStrings : viStrings;
    String text = key;
    if (selectedLanguage.containsKey(key) && selectedLanguage[key] != null) {
      text = selectedLanguage[key] ?? key;
    }
    return text;
  }
}

class TranslationConstants {
  static String unknownError = 'unknownError';
  static String notice = 'notice';
  static String close = 'close';
  static String continues = 'continues';
  static String setting = 'setting';
  static String cancel = 'cancel';
  static String noNetTitle = 'noNetTitle';
  static String noNetContent = 'noNetContent';
  static String retry = 'retry';
  static String allow = 'allow';
  static String removeAds = 'removeAds';
  static String privacy = 'privacy';
  static String termOfCondition = 'termOfCondition';
  static String contactUs = 'contactUs';
  static String shareApp = 'shareApp';
  static String language = 'language';
  static String chooseLanguage = 'chooseLanguage';
  static String restore = 'restore';
  static String moreApp = 'moreApp';
  static String errorLoadAds = 'errorLoadAds';
  static String shareMessage = 'shareMessage';
  static String bloodHealth = 'bloodHealth';
  static String heartRate = 'heartRate';
  static String descriptionHeartRate = "descriptionHeartRate";
  static String heartRateButton = "heartRateButton";
  static String bloodPressure = 'bloodPressure';
  static String bloodSugar = 'bloodSugar';
  static String weightAndBMI = 'weightAndBMI';
  static String foodScanner = 'foodScanner';
  static String scanFood = "scanFood";
  static String home = 'home';
  static String insights = 'insights';
  static String alarm = 'alarm';
  static String export = 'export';
  static String average = 'average';
  static String min = 'min';
  static String max = 'max';
  static String measureNow = 'measureNow';
  static String setAlarm = 'setAlarm';
  static String addData = 'addData';
  static String stop = 'stop';
  static String add = 'add';
  static String measuring = 'measuring';
  static String placeYourFinger = 'placeYourFinger';
  static String measureNowOrAdd = 'measureNowOrAdd';
  static String measure = 'measure';
  static String goPremium = 'goPremium';
  static String watchingAds = 'watchingAds';
  static String permissionCameraDenied01 = 'permissionCameraDenied01';
  static String permissionCameraSetting01 = 'permissionCameraSetting01';
  static String permissionCameraDenied02 = 'permissionCameraDenied02';
  static String permissionCameraSetting02 = 'permissionCameraSetting02';
  static String restingHeartRate = 'restingHeartRate';
  static String slow = 'slow';
  static String normal = 'normal';
  static String fast = 'fast';
  static String age = 'age';
  static String choseYourAge = 'choseYourAge';
  static String choseYourGender = 'choseYourGender';
  static String save = 'save';
  static String rhSlowMessage = 'rhSlowMessage';
  static String rhNormalMessage = 'rhNormalMessage';
  static String rhFastMessage = 'rhFastMessage';
  static String addSuccess = 'addSuccess';
  static String date = 'date';
  static String time = 'time';
  static String gender = 'gender';
  static String delete = 'delete';
  static String deleteData = 'deleteData';
  static String deleteDataConfirm = 'deleteDataConfirm';
  static String eng = "english";
  static String vi = "vietnamese";
  static String addYourRecordToSeeStatistics = "addYourRecordToSeeStatisitcs";
  static String systolic = "systolic";
  static String diastolic = "diastolic";
  static const String hypotension = "hypotension";
  static const String elevated = "elevated";
  static const String hypertensionStage1 = "hypertensionStage1";
  static const String hypertensionStage2 = "hypertensionStage2";
  static const String hypertensionCrisis = "hypertensionCrisis";
  static const String systolicRangeOrDiastolicRange = "systolicRangeOrDiastolicRange";
  static const String ok = "ok";
  static const String pulse = "pulse";
  static const String sysAndDIA = "sysAndDIA";
  static const String hypotensionMessage = "hypotensionMessage";
  static const String normalMessage = "normalMessage";
  static const String elevatedMessage = "elevatedMessage";
  static const String hypertensionStage1Message = "hypertensionStage1Message";
  static const String hypertensionStage2Message = "hypertensionStage2Message";
  static const String hypertensionCrisisMessage = "hypertensionCrisisMessage";
  static String edit = "edit";
  static String forSomething = "for";
  static String type = 'type';
  static String addDataSuccess = 'addDataSuccess';
  static String addDataFailed = 'addDataFailed';
  static String editDataSuccess = 'editDataSuccess';
  static String editDataFailed = 'editDataFailed';
  static String deleteDataSuccess = 'deleteDataSuccess';
  static String deleteDataFailed = 'deleteDataFailed';

  // Blood Sugar
  static String bloodSugarState = "bloodSugarState";
  static String bloodSugarAllState = "bloodSugarAllState";
  static String bloodSugarDefaultState = "bloodSugarDefaultState";
  static String duringFastingCode = "duringFastingCode";
  static String beforeEatingCode = "beforeEatingCode";
  static String afterEating1hCode = "afterEating1hCode";
  static String afterEating2hCode = "afterEating2hCode";
  static String beforeBedtimeCode = "beforeBedtimeCode";
  static String beforeWorkoutCode = "beforeWorkoutCode";
  static String afterWorkoutCode = "afterWorkoutCode";
  static String bloodSugarInforLow = "bloodSugarInforLow";
  static String bloodSugarInforNormal = "bloodSugarInforNormal";
  static String bloodSugarInforPreDiabetes = "bloodSugarInforPreDiabetes";
  static String bloodSugarInforDiabetes = "bloodSugarInforDiabetes";
  static String bloodSugarInfo = "bloodSugarInfo";

  static String trackYourHealth = "trackYourHealth";
  static String checkYourHeartRate = "checkYourHeartRate";
  static String checkYourWeightAndBMI = "checkYourWeightAndBMI";
  static String checkYourBloodSugar = "checkYourBloodSugar";
  static String checkYourBloodPressure = "checkYourBloodPressure";
  static String requestPermission = "requestPermission";
  static String noInformation = "noInformation";
  static String scanResult = "scanResult";
  static String qrCode = "qrCode";
  static String barcode = "barcode";
  static const String addAlarmSuccess = "addAlarmSuccessful";
  static const String updateAlarmSuccess = "updateAlarmSuccess";
  static const String deleteAlarmSuccess = "deleteAlarmSuccess";
  static const String deleteAlarmConfirmMsg = "deleteAlarmConfirmMsg";
  static const String noAlarm = "noAlarm";

  static final List<String> bloodPressureNotiMsgs =
      List<String>.generate(10, (index) => "bloodPressureNoti$index", growable: false);
  static final List<String> heartRateNotiMsgs = List<String>.generate(10, (index) => "heartRateNoti$index", growable: false);
  static final List<String> bloodSugarNotiMsgs =
      List<String>.generate(10, (index) => "bloodSugarNoti$index", growable: false);
  static final List<String> weightAndBMINotiMsgs =
      List<String>.generate(10, (index) => "bloodSugarNoti$index", growable: false);

  static const String deleteAlarmFailed = "deleteAlarmFailed";
  static const String updateAlarmFailed = "updateAlarmFailed";
  static const String addAlarmFailed = "addAlarmFailed";

  static const String confirm = "confirm";

  static const String remindToRecord = "remindToRecord";

  static String weight = "weight";
  static String height = "height";
  static String verySeverelyUnderweight = "verySeverelyUnderweight";
  static String severelyUnderweight = "severelyUnderweight";
  static String underweight = "underweight";
  static String overweight = "overweight";
  static String obeseClassI = "obeseClassI";
  static String obeseClassII = "obeseClassII";
  static String obeseClassIII = "obeseClassIII";
  static String bmiMessage = "bmiMessage";
  static String bmi = "bmi";

  static String subscribeTitle = "subscribeTitle";
  static String descriptionSub = "descriptionSub";
  static String descriptionSub1 = "descriptionSub1";
  static String subscribeContentIos1 = "subscribeContentIos1";
  static String subscribeContentIos2 = "subscribeContentIos2";
  static String subscribeContentIos3 = "subscribeContentIos3";
  static String subscribeContentIos4 = "subscribeContentIos4";
  static String subscribeContentIos5 = "subscribeContentIos5";
  static String subscribeContentIos6 = "subscribeContentIos6";
  static String subscribeContentAndroid1 = "subscribeContentAndroid1";
  static String subscribeContentAndroid2 = "subscribeContentAndroid2";
  static String subscribeContentAndroid3 = "subscribeContentAndroid3";
  static String subscribeContentAndroid4 = "subscribeContentAndroid4";
  static String subscribeContentAndroid5 = "subscribeContentAndroid5";
  static String subscribeContentAndroid6 = "subscribeContentAndroid6";
  static String privacyPolicy = "privacyPolicy";
  static String termService = "termService";
  static String subscribeAutoRenewable = "subscribeAutoRenewable";
  static String perYear = "perYear";
  static String perMonth = "perMonth";
  static String perWeek = "perWeek";
  static String only = "only";
  static String freeTrial = "3freeTrial";
  static String bestOffer = "bestOffer";

  static String selectLocation = "selectLocation";
  static String howOldAreYou = "howOldAreYou";
  static String whatGender = "whatGender";
  static String male = "male";
  static String female = "female";
  static String questionWhere = "questionWhere";
  static String next = "next";
}
