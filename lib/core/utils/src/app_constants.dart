import 'dart:ui';

import 'app_image.dart';

class AppConstant {
  AppConstant._();

  static String insightAsset = "assets/json/insight.json";

  static const int minHeartRate = 40;
  static const int maxHeartRate = 220;

  static final availableLocales = [
    const Locale('vi', 'VN'),
    const Locale('en', 'US'),
  ];

  static final List<Map> listGender = [
    {
      'id': '0',
      'nameEN': 'Male',
      'nameVN': 'Nam',
      'icon': AppImage.icMale,
    },
    {
      'id': '1',
      'nameEN': 'Female',
      'nameVN': 'Nữ',
      'icon': AppImage.icFemale,
    },
    {
      'id': '2',
      'nameEN': 'Other',
      'nameVN': 'Khác',
      'icon': AppImage.icMaleFemale,
    },
  ];
}
