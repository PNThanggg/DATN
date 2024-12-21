import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../presentation/theme/app_color.dart';
import '../../presentation/widget/app_touchable.dart';
import 'translation/app_translation.dart';

class AppPermission {
  static Future<PermissionStatus> checkPermission(
    BuildContext context,
    Permission permission,
    String messageDenied,
    String messageDeniedNeedSetting, {
    Function()? onGrant,
    Function()? onDenied,
    Function()? onOther,
    bool showErrorDialog = true,
  }) async {
    final status = await permission.request();
    if (status.isGranted) {
      if (onGrant != null) {
        onGrant();
      }
    } else if (status.isDenied) {
      if (onDenied != null) {
        onDenied();
      }
      if (context.mounted) {
        if (showErrorDialog) {
          showDialog(
            context: context,
            builder: (buildContext) {
              return AlertDialog(
                title: Text(TranslationConstants.notice.tr),
                content: Text(messageDenied),
                actions: [
                  AppTouchable(
                    onPressed: Get.back,
                    padding: EdgeInsets.symmetric(vertical: 4.0.sp, horizontal: 8.0.sp),
                    child: Text(
                      TranslationConstants.close.tr,
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.6),
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  AppTouchable(
                    onPressed: () {
                      Get.back();
                      checkPermission(context, permission, messageDenied, messageDeniedNeedSetting,
                          onGrant: onGrant, onDenied: onDenied, onOther: onOther);
                    },
                    padding: EdgeInsets.symmetric(vertical: 4.0.sp, horizontal: 8.0.sp),
                    child: Text(
                      TranslationConstants.continues.tr,
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      }
    } else {
      if (onOther != null) {
        onOther();
      }

      if (context.mounted) {
        if (showErrorDialog) {
          showDialog(
            context: context,
            builder: (buildContext) {
              return AlertDialog(
                title: Text(TranslationConstants.notice.tr),
                content: Text(messageDeniedNeedSetting),
                actions: [
                  AppTouchable(
                    onPressed: Get.back,
                    padding: EdgeInsets.symmetric(vertical: 4.0.sp, horizontal: 8.0.sp),
                    child: Text(
                      TranslationConstants.close.tr,
                      style: TextStyle(
                        color: AppColor.black.withOpacity(0.6),
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  AppTouchable(
                    onPressed: () {
                      Get.back();
                      openAppSettings();
                    },
                    padding: EdgeInsets.symmetric(vertical: 4.0.sp, horizontal: 8.0.sp),
                    child: Text(
                      TranslationConstants.setting.tr,
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 16.0.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      }
    }
    return status;
  }
}
