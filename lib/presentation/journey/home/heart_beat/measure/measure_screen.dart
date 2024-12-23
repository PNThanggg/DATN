import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../../common/constants/app_image.dart';
import '../../../../../common/util/translation/app_translation.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/theme_text.dart';
import '../../../../widget/app_container.dart';
import '../../../../widget/app_header.dart';
import '../../../../widget/app_image_widget.dart';
import '../../../../widget/app_touchable.dart';
import '../../../../widget/heart_bpm.dart';
import 'measure_controller.dart';

class MeasureScreen extends GetView<MeasureController> {
  const MeasureScreen({super.key});

  Widget _buildStateIdle() {
    String tutorialPath = AppImage.heart_rate_tutorial_android;
    if (Platform.isIOS) {
      tutorialPath = AppImage.heart_rate_tutorial_ios;
    }

    return Column(
      key: const ValueKey<int>(1),
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12.0.sp, 0, 12.0.sp, 0),
                  child: Center(
                    child: AppImageWidget.asset(
                      path: tutorialPath,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        AppTouchable.common(
          onPressed: controller.onPressStartMeasure,
          padding: EdgeInsets.symmetric(
            vertical: 12.0.sp,
          ),
          backgroundColor: AppColor.green,
          margin: EdgeInsets.fromLTRB(12.0.sp, 0, 12.0.sp, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImageWidget.asset(
                path: AppImage.ic_heart_rate,
                width: 32.0.sp,
              ),
              SizedBox(width: 8.0.sp),
              Text(
                TranslationConstants.measureNow.tr,
                style: textStyle18700().copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStateMeasure(BuildContext context) {
    double sizeCircle = Get.width / 1.725;

    return Column(
      key: const ValueKey<int>(0),
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => CircularPercentIndicator(
                  animation: true,
                  animationDuration: 200,
                  radius: sizeCircle / 2,
                  lineWidth: 10.0.sp,
                  percent: controller.progress.value < 0.0
                      ? 0.0
                      : controller.progress.value > 1.0
                          ? 1.0
                          : controller.progress.value,
                  circularStrokeCap: CircularStrokeCap.round,
                  animateFromLastPercent: true,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(17.0.sp, 0, 17.0.sp, 0),
                        child: AppImageWidget.asset(
                          path: AppImage.heart_rate_lottie,
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: AppColor.gray,
                  progressColor: AppColor.red,
                ),
              ),
              SizedBox(height: 24.0.sp),
              Obx(
                () => Text(
                  '${TranslationConstants.measuring.tr} (${(controller.progress.value * 100).toInt()}%)',
                  style: textStyle18400().copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 4.0.sp),
              Text(
                TranslationConstants.placeYourFinger.tr,
                style: textStyle18400().copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0.sp,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 24.0.sp),
              HeartBPMDialog(
                context: context,
                onBPM: controller.onBPM,
                onRawData: controller.onRawData,
                alpha: 0.5,
              )
            ],
          ),
        ),
        AppTouchable.common(
          onPressed: controller.onPressStopMeasure,
          width: Get.width,
          backgroundColor: AppColor.red,
          padding: EdgeInsets.symmetric(
            vertical: 12.0.sp,
          ),
          margin: EdgeInsets.fromLTRB(12.0.sp, 0, 12.0.sp, 0),
          child: Text(
            TranslationConstants.stop.tr,
            style: textStyle18700().copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16.0.sp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: TranslationConstants.measure.tr,
            leftWidget: BackButton(
              color: AppColor.black,
              onPressed: Get.back,
            ),
          ),
          Expanded(
            child: Obx(() {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: controller.currentMeasureScreenState.value == MeasureScreenState.measuring
                    ? _buildStateMeasure(context)
                    : _buildStateIdle(),
              );
            }),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom + 12.0.sp),
        ],
      ),
    );
  }
}
