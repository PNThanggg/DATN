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
                  padding: EdgeInsets.fromLTRB(17.0.sp, 0, 17.0.sp, 0),
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
          height: 70.0.sp,
          backgroundColor: AppColor.green,
          margin: EdgeInsets.fromLTRB(17.0.sp, 0, 17.0.sp, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppImageWidget.asset(
                path: AppImage.ic_heart_rate,
                width: 60.0.sp,
              ),
              SizedBox(width: 8.0.sp),
              Text(
                TranslationConstants.measureNow.tr,
                style: textStyle24700(),
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
              Obx(() => CircularPercentIndicator(
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
                  )),
              SizedBox(height: 30.0.sp),
              Obx(() => Text(
                    '${TranslationConstants.measuring.tr} (${(controller.progress.value * 100).toInt()}%)',
                    style: textStyle20500(),
                  )),
              SizedBox(height: 2.0.sp),
              Text(
                TranslationConstants.placeYourFinger.tr,
                style: textStyle18400(),
              ),
              SizedBox(height: 27.0.sp),
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
          height: 70.0.sp,
          width: Get.width,
          backgroundColor: AppColor.red,
          margin: EdgeInsets.fromLTRB(17.0.sp, 0, 17.0.sp, 0),
          child: Text(
            TranslationConstants.stop.tr,
            style: textStyle24700(),
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
          SizedBox(height: MediaQuery.of(context).padding.bottom + 17.0.sp),
        ],
      ),
    );
  }
}
