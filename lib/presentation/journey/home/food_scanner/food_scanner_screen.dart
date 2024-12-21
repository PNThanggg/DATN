import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/util/translation/app_translation.dart';
import '../../../theme/app_color.dart';
import '../../../theme/theme_text.dart';
import '../../../widget/app_container.dart';
import '../../../widget/app_header.dart';
import '../../../widget/app_touchable.dart';
import 'food_scanner_controller.dart';

class FoodScannerScreen extends GetView<FoodScannerController> {
  const FoodScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: TranslationConstants.scanFood.tr,
            leftWidget: AppTouchable.common(
              onPressed: () => Get.back(),
              decoration: const BoxDecoration(boxShadow: null),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppColor.black,
              ),
            ),
            rightWidget: Obx(
              () => AppTouchable.common(
                onPressed: controller.toggleFlash,
                decoration: const BoxDecoration(boxShadow: null),
                child: Icon(
                  controller.isFlashOn.value ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                  color: controller.isFlashOn.value ? AppColor.gold : AppColor.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoadingQrCamera.value) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              switch (controller.permissionStatusCamera.value) {
                case PermissionStatus.denied:
                  return _permissionDenied(context);
                case PermissionStatus.granted:
                case PermissionStatus.restricted:
                case PermissionStatus.limited:
                  return _scannerView();
                case PermissionStatus.permanentlyDenied:
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(TranslationConstants.permissionCameraDenied01.tr),
                        SizedBox(
                          height: 12.0.sp,
                        ),
                        AppTouchable(
                          onPressed: () {
                            controller.onPressRequestPermissionCamera(context);
                          },
                          child: Text(TranslationConstants.requestPermission.tr),
                        ),
                      ],
                    ),
                  );
                case PermissionStatus.provisional:
                  return const SizedBox.shrink();
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _scannerView() {
    return Column(
      children: [
        // SizedBox(
        //   height: 360.0.sp,
        //   child: ClipRRect(
        //     borderRadius: BorderRadius.circular(10.0.sp),
        //     child: QRView(
        //       key: controller.qrCameraKey,
        //       onQRViewCreated: controller.onQRViewCreated,
        //       overlay: QrScannerOverlayShape(
        //         borderColor: AppColor.primaryColor,
        //         borderWidth: 5.0.sp,
        //         borderRadius: 10.0.sp,
        //         cutOutWidth: controller.selectedDataMapTypeTab["id"] == 1 ? 330.0.sp : 280.0.sp,
        //         cutOutHeight: controller.selectedDataMapTypeTab.value['id'] == 1 ? 120.0.sp : 280.0.sp,
        //       ),
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 32.0.sp,
        ),
        // Obx(
        //   () => Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: controller.listDataMapTypeTab.map(
        //       (type) {
        //         return AppTouchable(
        //           padding: EdgeInsets.symmetric(horizontal: 12.0.sp, vertical: 8.0.sp),
        //           decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(4.0.sp),
        //             color: controller.selectedDataMapTypeTab == type ? AppColor.black.withOpacity(0.4) : AppColor.white,
        //           ),
        //           onPressed: () {
        //             return controller.selectedDataMapTypeTab.value = type;
        //           },
        //           child: Text(
        //             type["name"],
        //             style: textStyle16400().copyWith(
        //               color: controller.selectedDataMapTypeTab == type ? AppColor.white : AppColor.black,
        //             ),
        //           ),
        //         );
        //       },
        //     ).toList(growable: false),
        //   ),
        // )
      ],
    );
  }

  Widget _permissionDenied(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            TranslationConstants.permissionCameraDenied02.tr,
            textAlign: TextAlign.center,
            style: textStyle16400(),
          ),
          SizedBox(
            height: 12.0.sp,
          ),
          AppTouchable.commonRadius20(
            onPressed: () {
              controller.onPressRequestPermissionCamera(context);
            },
            backgroundColor: AppColor.green,
            padding: EdgeInsets.symmetric(
              vertical: 12.0.sp,
              horizontal: 20.0.sp,
            ),
            child: Text(
              TranslationConstants.requestPermission.tr,
              style: textStyle16500().copyWith(
                color: AppColor.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
