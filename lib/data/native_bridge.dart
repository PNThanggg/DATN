import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'native_bridge_result.dart';

class NativeBridge {
  static final String tag = '--NativeBridge ${Platform.operatingSystem}--: ';

  MethodChannel? platform;
  static final _instance = NativeBridge._internal();

  NativeBridge._internal() {
    platform = const MethodChannel('method_channel_name');
  }

  static NativeBridge getInstance() {
    return _instance;
  }

  Future<NativeBridgeResult> sendMessage(List<String> listMessage) async {
    NativeBridgeResult result = NativeBridgeResult();

    try {
      final resultNative = await platform?.invokeMethod('sendMessage', {
        'listMessage': listMessage,
      });

      debugPrint("Result native: ${resultNative.toString()}");

      result = NativeBridgeResult(
        success: true,
        code: '1',
        message: 'Success',
        data: resultNative,
      );

      printMessage(result.data.toString());
    } on PlatformException catch (e) {
      result = NativeBridgeResult(
        success: false,
        code: e.code,
        message: e.message,
        data: null,
      );

      printMessage(result.message ?? "Error", isError: true);
    }

    return result;
  }

  Future<NativeBridgeResult> homeWidget() async {
    NativeBridgeResult result = NativeBridgeResult();

    try {
      final resultNative = await platform?.invokeMethod('home_widget');

      debugPrint("Result native: ${resultNative.toString()}");

      result = NativeBridgeResult(
        success: true,
        code: '1',
        message: 'Success',
        data: resultNative,
      );

      printMessage("Home widget: ${result.data.toString()}");
    } on PlatformException catch (e) {
      result = NativeBridgeResult(
        success: false,
        code: e.code,
        message: e.message,
        data: null,
      );

      printMessage(result.message ?? "Error", isError: true);
    }

    return result;
  }

  void printMessage(String message, {bool isError = false}) {
    if (isError) {
      debugPrint('ERROR $tag $message');
    } else {
      debugPrint(tag + message.toString());
    }
  }
}
