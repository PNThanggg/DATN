import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:workmanager/workmanager.dart';

class HomeWidgetConfig {
  @pragma('vm:entry-point')
  static Future<void> backgroundCallback(Uri? uri) async {
    // debugPrint("backgroundCallback uri: ${uri?.data}");
    // if (uri?.host == "updateData") {
    //   Future.wait<bool?>(
    //     [
    //       HomeWidget.saveWidgetData<String>('time', null),
    //       HomeWidget.saveWidgetData<String>('day', null),
    //       HomeWidget.saveWidgetData<int>('bpm', -1),
    //     ],
    //   ).then((value) {
    //     _updateWidget();
    //   });
    // }
  }

  @pragma('vm:entry-point')
  static Future<void> callbackDispatcher() async {
    // Workmanager().executeTask((taskName, inputData) {
    //   return Future.wait<bool?>(
    //     [
    //       HomeWidget.saveWidgetData<String>('time', null),
    //       HomeWidget.saveWidgetData<String>('day', null),
    //       HomeWidget.saveWidgetData<int>('bpm', -1),
    //       _updateWidget(),
    //     ],
    //   ).then((value) {
    //     return !value.contains(false);
    //   });
    // });
  }

  static Future<bool?> _updateWidget() async {
    // try {
    //   return HomeWidget.updateWidget(
    //     name: 'MyHomeWidgetProvider',
    //     androidName: 'MyHomeWidgetProvider',
    //     iOSName: 'MyHomeWidgetProvider',
    //     qualifiedAndroidName: 'com.vietapps.bloodpressure.MyHomeWidgetProvider',
    //   );
    // } on PlatformException catch (exception) {
    //   debugPrint('Error Updating Widget. $exception');
    //   return null;
    // }
  }

  static Future<void> sendAndUpdate(Map<String, dynamic> data) async {
    // debugPrint("send and update data home widget");
    //
    // try {
    //   Future.wait(
    //     [
    //       HomeWidget.saveWidgetData<String>('time', data['time'] as String),
    //       HomeWidget.saveWidgetData<String>('day', data['day'] as String),
    //       HomeWidget.saveWidgetData<int>('bpm', data['bpm'] as int),
    //     ],
    //   );
    //
    //   _updateWidget();
    // } on PlatformException catch (exception) {
    //   debugPrint('Error Sending Data: $exception');
    // }
  }
}
