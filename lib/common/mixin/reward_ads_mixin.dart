import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../presentation/theme/app_color.dart';
import '../../presentation/widget/app_image_widget.dart';
import '../../presentation/widget/app_touchable.dart';
import '../constants/app_image.dart';
import '../util/translation/app_translation.dart';

mixin RewardAdsMixin {
  Future<void> showRewardAdsDialog(
    BuildContext context, {
    Function()? onPressAccess,
    Function()? onPressGoPremium,
  }) async {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            alignment: Alignment.center,
            elevation: 0,
            child: Container(
              width: Get.width * 0.85,
              padding: EdgeInsets.symmetric(vertical: 16.0.sp, horizontal: 18.0.sp),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20.0.sp))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      AppTouchable(
                          onPressed: Get.back,
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 20,
                          )),
                      Expanded(
                          child: Text(
                        TranslationConstants.measure.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColor.black,
                          height: 25 / 20,
                        ),
                      )),
                      const SizedBox(width: 20),
                    ],
                  ),
                  SizedBox(height: 20.0.sp),
                  AppImageWidget.asset(
                    path: AppImage.dialogRewardAds,
                    width: 80.0.sp,
                    height: 80.0.sp,
                  ),
                  SizedBox(height: 20.0.sp),
                  AppTouchable(
                      onPressed: onPressGoPremium,
                      rippleColor: Colors.transparent,
                      child: Container(
                        width: Get.width,
                        height: 70.0.sp,
                        margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
                          color: const Color(0xFF0B8C10),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 20.0.sp),
                            AppImageWidget.asset(
                              path: AppImage.dialogPremiumBackground,
                              width: 45.0.sp,
                              height: 45.sp,
                            ),
                            Expanded(
                                child: Text(
                              TranslationConstants.goPremium.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                            SizedBox(width: 20.0.sp),
                          ],
                        ),
                      )),
                  SizedBox(height: 12.0.sp),
                  AppTouchable(
                    onPressed: onPressAccess,
                    rippleColor: Colors.transparent,
                    child: Container(
                      width: Get.width,
                      height: 70.0.sp,
                      margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0.sp)),
                        border: Border.all(color: const Color(0xFFA4A4A4), width: 2.0.sp),
                        color: const Color(0xFFFFFFFF),
                      ),
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            TranslationConstants.watchingAds.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFFA4A4A4),
                              fontSize: 20.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
    return;
  }
}
