import 'package:datn/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppImageWidget.asset(
              path: AppImage.imgSplash,
              height: 130.0.sp,
              width: 130.0.sp,
            ),
            Text(
              "Health Pulse",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColor.defaultTextColor,
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
