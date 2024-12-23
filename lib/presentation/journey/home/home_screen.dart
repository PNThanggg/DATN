import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../common/constants/app_image.dart';
import '../../../common/util/disable_glow_behavior.dart';
import '../../../common/util/translation/app_translation.dart';
import '../../theme/app_color.dart';
import '../../theme/theme_text.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/app_touchable.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: TranslationConstants.bloodHealth.tr,
            leftWidget: SizedBox(width: 40.0.sp),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: const DisableGlowBehavior(),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0.sp),
                child: Column(
                  children: [
                    Container(
                      width: Get.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFC8D8D),
                            Color(0xFFC53535),
                          ],
                          begin: Alignment(-1.0, -4.0),
                          end: Alignment(1.0, 4.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(
                                left: Get.width * 0.05,
                                right: Get.width * 0.05,
                              ),
                              child: Stack(
                                children: [
                                  LottieBuilder.asset(AppImage.heartScan),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: LottieBuilder.asset(
                                      AppImage.heartRate,
                                      width: 80.0.sp,
                                      height: 70.0.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  TranslationConstants.heartRate.tr,
                                  style: TextStyle(
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.white,
                                  ),
                                ),
                                SizedBox(height: 10.0.sp),
                                Text(
                                  TranslationConstants.descriptionHeartRate.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12.0.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.white,
                                  ),
                                ),
                                SizedBox(height: 20.0.sp),
                                AppTouchable.common(
                                  onPressed: controller.onPressHeartBeat,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFFFFFFF),
                                        Color(0xFFD9D9D9),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF000000).withOpacity(0.4),
                                        offset: const Offset(0, 0),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.0.sp,
                                      horizontal: 30.0.sp,
                                    ),
                                    child: Text(
                                      TranslationConstants.heartRateButton.tr,
                                      style: TextStyle(
                                        fontSize: 16.0.sp,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFFC73838),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 8.0.sp),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0.sp),
                    Row(
                      children: [
                        Expanded(
                          child: AppTouchable.common(
                            backgroundColor: const Color(0xFF97C7FF),
                            onPressed: controller.onPressBloodPressure,
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0.sp
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppImageWidget.asset(
                                  path: AppImage.bloodPressure,
                                  width: 60.0.sp,
                                ),
                                SizedBox(height: 4.0.sp),
                                Text(
                                  TranslationConstants.bloodPressure.tr,
                                  style: textStyle18500().copyWith(
                                    color: AppColor.white,
                                    fontSize: 16.0.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0.sp),
                        Expanded(
                          child: AppTouchable.common(
                            backgroundColor: const Color(0xFF6DB80D),
                            onPressed: controller.onPressWeightAndBMI,
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0.sp
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppImageWidget.asset(
                                  path: AppImage.weightBmi,
                                  width: 60.0.sp,
                                ),
                                SizedBox(height: 4.0.sp),
                                Text(
                                  TranslationConstants.weightAndBMI.tr,
                                  style: textStyle18500().copyWith(
                                    color: AppColor.white,
                                    fontSize: 16.0.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0.sp),
                    Row(
                      children: [
                        Expanded(
                          child: AppTouchable.common(
                            backgroundColor: const Color(0xFFFFEFC6),
                            onPressed: controller.onPressFoodScanner,
                            padding: EdgeInsets.symmetric(
                              vertical: 20.0.sp
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppImageWidget.asset(
                                  path: AppImage.ic_qr_code,
                                  width: 60.0.sp,
                                ),
                                SizedBox(height: 4.0.sp),
                                Text(
                                  TranslationConstants.foodScanner.tr,
                                  style: textStyle18500().copyWith(
                                    color: AppColor.grayText,
                                    fontSize: 16.0.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
