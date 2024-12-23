import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/constants/enums.dart';
import '../theme/app_color.dart';
import 'app_header.dart';
import 'app_touchable.dart';

class BloodHeaderWidget extends StatelessWidget {
  final String title;
  final Color background;
  final Widget extendWidget;
  final LoadedType? exportLoaded;

  const BloodHeaderWidget({
    super.key,
    required this.title,
    required this.background,
    required this.extendWidget,
    this.exportLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return AppHeader(
      title: title,
      decoration: BoxDecoration(
        color: background,
      ),
      titleStyle: const TextStyle(color: AppColor.white),
      leftWidget: AppTouchable(
        width: 40.0.sp,
        height: 40.0.sp,
        onPressed: Get.back,
        child: BackButton(
          color: AppColor.white,
          onPressed: () => Get.back(),
        ),
      ),
      extendWidget: extendWidget,
    );
  }
}
