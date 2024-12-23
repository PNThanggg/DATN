import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../common/util/app_permission.dart';
import '../../../../common/util/translation/app_translation.dart';

class FoodScannerController extends GetxController {
  final BuildContext context = Get.context!;
  final GlobalKey qrCameraKey = GlobalKey(debugLabel: 'QR');
  final RxBool isLoadingQrCamera = false.obs;
  final RxBool isFlashOn = false.obs;

  final MobileScannerController mobileScannerController = MobileScannerController(
    autoStart: false,
    torchEnabled: true,
    useNewCameraSelector: true,
    formats: const [
      BarcodeFormat.qrCode,
    ],
  );


  // QRViewController? qrViewController;
  List<Map> listDataMapTypeTab = [
    {
      'id': 0,
      'name': 'QR code',
      "types": {
        BarcodeFormat.dataMatrix,
        BarcodeFormat.aztec,
        BarcodeFormat.codebar,
      }
    },
    {
      'id': 1,
      'name': 'Barcode',
      "types": {
        BarcodeFormat.code39,
        BarcodeFormat.code93,
        BarcodeFormat.upcA,
        BarcodeFormat.upcE,
        BarcodeFormat.ean8,
        BarcodeFormat.ean13,
        BarcodeFormat.codabar,
        BarcodeFormat.code128,
        BarcodeFormat.itf,
        BarcodeFormat.pdf417,
        BarcodeFormat.unknown,
      }
    },
  ];

  Rx<PermissionStatus> permissionStatusCamera = PermissionStatus.denied.obs;
  RxMap selectedDataMapTypeTab = RxMap();

  @override
  void onInit() {
    selectedDataMapTypeTab.value = listDataMapTypeTab[0];
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

  @override
  void dispose() {
    mobileScannerController.dispose();
    super.dispose();
  }

  void toggleFlash() {
    if (permissionStatusCamera.value == PermissionStatus.denied ||
        permissionStatusCamera.value == PermissionStatus.permanentlyDenied) {
      return;
    }
    mobileScannerController.toggleTorch();
    isFlashOn.value = !isFlashOn.value;
  }

  void onPressRequestPermissionCamera(BuildContext context) {
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
