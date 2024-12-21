import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/util/app_permission.dart';
import '../../../../common/util/translation/app_translation.dart';

class FoodScannerController extends GetxController {
  final BuildContext context = Get.context!;
  final GlobalKey qrCameraKey = GlobalKey(debugLabel: 'QR');
  final RxBool isLoadingQrCamera = false.obs;
  final RxBool isFlashOn = false.obs;
  // QRViewController? qrViewController;
  // List<Map> listDataMapTypeTab = [
  //   {
  //     'id': 0,
  //     'name': 'QR code',
  //     "types": {
  //       BarcodeFormat.qrcode,
  //       BarcodeFormat.dataMatrix,
  //       BarcodeFormat.aztec,
  //       BarcodeFormat.maxicode,
  //     }
  //   },
  //   {
  //     'id': 1,
  //     'name': 'Barcode',
  //     "types": {
  //       BarcodeFormat.code39,
  //       BarcodeFormat.code93,
  //       BarcodeFormat.upcA,
  //       BarcodeFormat.upcE,
  //       BarcodeFormat.ean8,
  //       BarcodeFormat.ean13,
  //       BarcodeFormat.codabar,
  //       BarcodeFormat.rss14,
  //       BarcodeFormat.rssExpanded,
  //       BarcodeFormat.code128,
  //       BarcodeFormat.itf,
  //       BarcodeFormat.pdf417,
  //       BarcodeFormat.upcEanExtension,
  //       BarcodeFormat.unknown,
  //     }
  //   },
  // ];

  Rx<PermissionStatus> permissionStatusCamera = PermissionStatus.denied.obs;
  RxMap selectedDataMapTypeTab = RxMap();

  @override
  void onInit() {
    // selectedDataMapTypeTab.value = listDataMapTypeTab[0];
    Permission.camera.status.then((status) {
      permissionStatusCamera.value = status;
    });
    super.onInit();
  }

  initCamera() async {
    isLoadingQrCamera.value = true;
    permissionStatusCamera.value = await Permission.camera.status;
    isLoadingQrCamera.value = false;
  }

  // void onQRViewCreated(QRViewController controller) {
  //   qrViewController = controller;
  //   controller.resumeCamera();
  //   controller.scannedDataStream.listen(
  //     (Barcode scanData) async {
  //       if ((selectedDataMapTypeTab["types"] as Set<BarcodeFormat>).contains(scanData.format)) {
  //         final canOpenUrl = await canLaunchUrlString(scanData.code ?? "");
  //         controller.pauseCamera();
  //
  //         if(context.mounted) {
  //           await showAppDialog(
  //             context,
  //             TranslationConstants.scanResult.tr,
  //             "",
  //             widgetBody: Padding(
  //               padding: EdgeInsets.all(32.0.sp).copyWith(bottom: 24.sp),
  //               child: Column(
  //                 children: [
  //                   ConstrainedBox(
  //                     constraints: BoxConstraints(maxHeight: 280.sp),
  //                     child: ScrollConfiguration(
  //                       behavior: const DisableGlowBehavior(),
  //                       child: SingleChildScrollView(
  //                         child: canOpenUrl
  //                             ? AppTouchable(
  //                           onPressed: () {
  //                             launchUrlString(scanData.code!);
  //                           },
  //                           child: Text(
  //                             scanData.code!,
  //                             style: textStyle18500().copyWith(
  //                               color: AppColor.blue98EB,
  //                             ),
  //                           ),
  //                         )
  //                             : Text(
  //                           scanData.code ?? TranslationConstants.noInformation.tr,
  //                           style: textStyle18500().copyWith(height: 1.5),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 32.0.sp,
  //                   ),
  //                   AppTouchable(
  //                     backgroundColor: AppColor.green,
  //                     padding: EdgeInsets.symmetric(
  //                       horizontal: 72.0.sp,
  //                       vertical: 18.0.sp,
  //                     ),
  //                     onPressed: () {
  //                       Get.back();
  //                     },
  //                     child: Text(
  //                       TranslationConstants.ok.tr.toUpperCase(),
  //                       style: textStyle24700().copyWith(
  //                         color: AppColor.white,
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             hideGroupButton: true,
  //           );
  //         }
  //         controller.resumeCamera();
  //       }
  //     },
  //   );
  // }

  @override
  void dispose() {
    // qrViewController?.dispose();
    super.dispose();
  }

  void toggleFlash() {
    if (permissionStatusCamera.value == PermissionStatus.denied ||
        permissionStatusCamera.value == PermissionStatus.permanentlyDenied) {
      return;
    }
    // qrViewController?.toggleFlash();
    isFlashOn.value = !isFlashOn.value;
  }

  onPressRequestPermissionCamera(BuildContext context) {
    AppPermission.checkPermission(
      context,
      Permission.camera,
      TranslationConstants.permissionCameraDenied01.tr,
      TranslationConstants.permissionCameraSetting01.tr,
      onGrant: () {
        initCamera();
      },
      onDenied: () {
        initCamera();
      },
      onOther: () {
        initCamera();
      },
    );
  }
}
