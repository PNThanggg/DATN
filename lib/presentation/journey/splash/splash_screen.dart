import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/constants/app_image.dart';
import '../../theme/app_color.dart';
import '../../widget/app_container.dart';
import '../../widget/app_image_widget.dart';
import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return AppContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AppImageWidget.asset(
              path: AppImage.logo,
              width: Get.width * 0.25,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 12.0.sp),
          Text(
            'Blood Pressure',
            style: TextStyle(
              fontSize: 24.0.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.primaryColor,
            ),
          ),
          SizedBox(height: 12.0.sp),
          const CircularProgressIndicator(
            color: AppColor.secondaryColor,
          ),
        ],
      ),
    );
  }
}
