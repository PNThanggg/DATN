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
  final Function() onExported;
  final LoadedType? exportLoaded;
  final bool isLoading;

  const BloodHeaderWidget({
    super.key,
    required this.title,
    required this.background,
    required this.extendWidget,
    required this.onExported,
    required this.isLoading,
    this.exportLoaded,
  });

  @override
  Widget build(BuildContext context) {
    return AppHeader(
      title: title,
      decoration: BoxDecoration(
        color: background,
        boxShadow: [
          BoxShadow(
            color: const Color(0x40000000),
            offset: Offset(0, 4.0.sp),
            blurRadius: 4.0.sp,
          ),
        ],
      ),
      titleStyle: const TextStyle(color: AppColor.white),
      leftWidget: SizedBox(
        width: 80.0.sp,
        child: Row(
          children: [
            AppTouchable(
              width: 40.0.sp,
              height: 40.0.sp,
              padding: EdgeInsets.all(2.0.sp),
              onPressed: Get.back,
              outlinedBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.0.sp),
              ),
              child: BackButton(
                color: AppColor.white,
                onPressed: () => Get.back(),
              ),
            ),
            const Spacer()
          ],
        ),
      ),
      rightWidget: ExportButton(
        titleColor: background,
        onPressed: onExported,
        isLoading: isLoading,
      ),
      extendWidget: extendWidget,
    );
  }
}
