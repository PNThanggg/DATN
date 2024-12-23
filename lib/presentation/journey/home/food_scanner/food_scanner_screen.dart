import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../common/util/disable_glow_behavior.dart';
import '../../../../common/util/translation/app_translation.dart';
import '../../../theme/app_color.dart';
import '../../../theme/theme_text.dart';
import '../../../widget/app_container.dart';
import '../../../widget/app_dialog.dart';
import '../../../widget/app_header.dart';
import '../../../widget/app_touchable.dart';
import 'food_scanner_controller.dart';
import 'scanner_error_widget.dart';

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
              width: 40.0.sp,
              height: 40.0.sp,
              child: const Icon(
                Icons.arrow_back_rounded,
                color: AppColor.black,
              ),
            ),
            rightWidget: Obx(
              () => AppTouchable.common(
                onPressed: controller.toggleFlash,
                decoration: const BoxDecoration(boxShadow: null),
                width: 40.0.sp,
                height: 40.0.sp,
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
                  return _scannerView(context);
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

  Widget _scannerView(BuildContext context) {
    final Rect scanQRWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset(0, -80.0.sp)),
      width: 200,
      height: 200,
    );

    final Rect scanBarCodeWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset(0, -80.0.sp)),
      width: 300,
      height: 100,
    );

    bool isShowDialog = false;

    return Column(
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Center(
                child: Obx(
                  () => MobileScanner(
                    fit: BoxFit.contain,
                    controller: controller.mobileScannerController,
                    scanWindow: controller.selectedDataMapTypeTab == controller.listDataMapTypeTab.first
                        ? scanQRWindow
                        : scanBarCodeWindow,
                    errorBuilder: (context, error, child) {
                      return ScannerErrorWidget(error: error);
                    },
                    onDetect: (barcodes) async {
                      final bool canOpenUrl = await canLaunchUrlString(barcodes.barcodes.first.displayValue ?? "");

                      if (!isShowDialog) {
                        isShowDialog = true;
                        if (context.mounted) {
                          await showAppDialog(
                            context,
                            TranslationConstants.scanResult.tr,
                            "",
                            widgetBody: Padding(
                              padding: EdgeInsets.all(12.0.sp),
                              child: Column(
                                children: [
                                  ScrollConfiguration(
                                    behavior: const DisableGlowBehavior(),
                                    child: SingleChildScrollView(
                                      child: canOpenUrl
                                          ? AppTouchable(
                                              onPressed: () {
                                                launchUrlString(barcodes.barcodes.first.rawValue ?? '');
                                              },
                                              child: Text(
                                                barcodes.barcodes.first.rawValue ?? '',
                                                style: textStyle18500().copyWith(
                                                  color: AppColor.blue98EB,
                                                  fontSize: 16.0.sp,
                                                ),
                                              ),
                                            )
                                          : Text(
                                              barcodes.barcodes.first.rawValue ?? TranslationConstants.noInformation.tr,
                                              style: textStyle18500().copyWith(
                                                fontSize: 16.0.sp,
                                              ),
                                            ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.0.sp,
                                  ),
                                  AppTouchable(
                                    backgroundColor: AppColor.green,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 72.0.sp,
                                      vertical: 18.0.sp,
                                    ),
                                    onPressed: () {
                                      Get.back();
                                      isShowDialog = false;
                                    },
                                    child: Text(
                                      TranslationConstants.ok.tr.toUpperCase(),
                                      style: textStyle24700().copyWith(
                                        color: AppColor.white,
                                        fontSize: 16.0.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            hideGroupButton: true,
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: controller.mobileScannerController,
                builder: (context, value, child) {
                  if (!value.isInitialized || !value.isRunning || value.error != null) {
                    return const SizedBox.shrink();
                  }

                  return Obx(
                    () {
                      if (controller.selectedDataMapTypeTab == controller.listDataMapTypeTab.first) {
                        return CustomPaint(
                          painter: ScannerOverlay(
                            scanWindow: scanQRWindow,
                          ),
                        );
                      } else {
                        return CustomPaint(
                          painter: ScannerOverlay(
                            scanWindow: scanBarCodeWindow,
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16.0.sp,
        ),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: controller.listDataMapTypeTab.map(
              (type) {
                return AppTouchable(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.sp, vertical: 8.0.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0.sp),
                    color: controller.selectedDataMapTypeTab == type ? AppColor.black.withOpacity(0.4) : AppColor.white,
                  ),
                  onPressed: () {
                    controller.selectedDataMapTypeTab.value = type;
                  },
                  child: Text(
                    type["name"],
                    style: textStyle16400().copyWith(
                      color: controller.selectedDataMapTypeTab == type ? AppColor.white : AppColor.black,
                    ),
                  ),
                );
              },
            ).toList(growable: false),
          ),
        ),
        SizedBox(
          height: 12.0.sp,
        ),
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

class ScannerOverlay extends CustomPainter {
  const ScannerOverlay({
    required this.scanWindow,
    this.borderRadius = 12.0,
  });

  final Rect scanWindow;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    // we need to pass the size to the custom paint widget
    final backgroundPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOver;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    // First, draw the background,
    // with a cutout area that is a bit larger than the scan window.
    // Finally, draw the scan window itself.
    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow || borderRadius != oldDelegate.borderRadius;
  }
}
