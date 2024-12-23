import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/constants/app_constant.dart';
import '../../../../common/constants/app_route.dart';
import '../../../../common/mixin/alarm_dialog_mixin.dart';
import '../../../../common/util/app_util.dart';
import '../../../../common/util/show_snack_bar.dart';
import '../../../../common/util/translation/app_translation.dart';
import '../../../../domain/enum/alarm_type.dart';
import '../../../../domain/model/heart_rate_model.dart';
import '../../../controller/app_controller.dart';
import '../../../theme/app_color.dart';
import '../../../widget/app_dialog.dart';
import '../../../widget/app_dialog_heart_rate_widget.dart';
import '../../alarm/alarm_controller.dart';

class HeartBeatController extends GetxController with AlarmDialogMixin {
  late BuildContext context;
  final AppController appController = Get.find<AppController>();

  RxBool isLoading = false.obs;
  Rx<HeartRateModel> currentHeartRateModel = HeartRateModel().obs;
  RxInt hrAvg = 0.obs;
  RxInt hrMin = 0.obs;
  RxInt hrMax = 0.obs;
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> endDate = DateTime.now().obs;
  RxBool isExporting = false.obs;

  Rx<DateTime> chartMinDate = DateTime.now().obs;
  Rx<DateTime> chartMaxDate = DateTime.now().obs;
  RxDouble chartSelectedX = 0.0.obs;

  final alarmController = Get.find<AlarmController>();

  @override
  void onInit() {
    endDate.value = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      23,
      59,
      59,
    );
    DateTime temp = endDate.value.subtract(const Duration(days: 7));
    startDate.value = DateTime(temp.year, temp.month, temp.day);
    super.onInit();
  }

  @override
  void onReady() {
    _initData();

    super.onReady();
  }

  void _initData() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    isLoading.value = false;
    List<String>? heartRateDataString = prefs.getStringList('heartRateData');
    if ((heartRateDataString ?? []).isNotEmpty) {
      appController.listHeartRateModelAll = heartRateDataString!
          .map(
            (e) => HeartRateModel.fromJson(
              jsonDecode(e),
            ),
          )
          .toList();
      _handleData();
    }
  }

  _handleData() {
    List<HeartRateModel> listHeartRateModelTemp = [];
    for (final item in appController.listHeartRateModelAll) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(item.timeStamp ?? 0);
      if (dateTime.isAfter(startDate.value) && dateTime.isBefore(endDate.value)) {
        listHeartRateModelTemp.add(item);
      }
    }
    appController.listHeartRateModel.value = [...listHeartRateModelTemp];
    _generateDataChart();

    if (appController.listHeartRateModel.isNotEmpty) {
      currentHeartRateModel.value = appController.listHeartRateModel.last;
      int t = 0;
      int min = appController.listHeartRateModel.first.value ?? 0;
      int max = appController.listHeartRateModel.first.value ?? 0;
      for (final item in appController.listHeartRateModel) {
        t += (item.value ?? 0);
        if ((item.value ?? 0) < min) {
          min = item.value ?? 0;
        }
        if ((item.value ?? 0) > max) {
          max = item.value ?? 0;
        }
      }
      hrAvg.value = t ~/ appController.listHeartRateModel.length;
      hrMin.value = min;
      hrMax.value = max;
    }
    chartSelectedX.value = 0.0;
  }

  void addHeartRateData(HeartRateModel heartRateModel) async {
    appController.listHeartRateModelAll.add(heartRateModel);
    _handleData();
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'heartRateData',
      appController.listHeartRateModelAll
          .map(
            (element) => jsonEncode(
              element.toJson(),
            ),
          )
          .toList(),
    );
  }

  Future<void> deleteHeartRateData(HeartRateModel heartRateModel) async {
    HeartRateModel? heartRateModelTemp = appController.listHeartRateModelAll.firstWhereOrNull(
      (element) => element.timeStamp == heartRateModel.timeStamp,
    );
    if (heartRateModelTemp != null) {
      appController.listHeartRateModelAll.remove(heartRateModelTemp);
    }
    _handleData();
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'heartRateData',
      appController.listHeartRateModelAll
          .map(
            (element) => jsonEncode(
              element.toJson(),
            ),
          )
          .toList(),
    );
  }

  void onPressMeasureNow() async {
    Get.toNamed(AppRoute.measureScreen);
  }

  void onPressDateRange() async {
    DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        start: startDate.value,
        end: endDate.value,
      ),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      locale: Get.find<AppController>().currentLocale,
      builder: (context, Widget? child) => Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(
            onPrimary: AppColor.white,
            primary: AppColor.red,
          ),
        ),
        child: child!,
      ),
    );
    if (result != null) {
      startDate.value = DateTime(result.start.year, result.start.month, result.start.day);
      endDate.value = DateTime(
        result.end.year,
        result.end.month,
        result.end.day,
        23,
        59,
        59,
      );
      _handleData();
    }
  }

  onPressAddData() async {
    showAppDialog(
      context,
      '',
      '',
      hideGroupButton: true,
      widgetBody: AppDialogHeartRateWidget(
        allowChange: true,
        inputDateTime: DateTime.now(),
        inputValue: 70,
        onPressCancel: () {
          Get.back();
        },
        onPressAdd: (dateTime, value) async {
          _addData(dateTime, value);
        },
      ),
    );
  }

  void _addData(dateTime, value) {
    if (Get.isRegistered<HeartBeatController>()) {
      Get.find<HeartBeatController>().addHeartRateData(
        HeartRateModel(
          timeStamp: dateTime.millisecondsSinceEpoch,
          value: value,
          age: appController.currentUser.value.age ?? 30,
          genderId: appController.currentUser.value.genderId ?? '0',
        ),
      );
    }

    Get.back();
    showSnackBar(context, subtitle: TranslationConstants.addSuccess.tr);
    // _recentBPM = 0;
  }

  Future<void> onPressExport() async {
    isExporting.value = true;
    List<String> header = [];
    List<List<String>> listOfData = [];
    header.add(TranslationConstants.date.tr);
    header.add(TranslationConstants.time.tr);
    header.add(TranslationConstants.age.tr);
    header.add(TranslationConstants.gender.tr);
    header.add('BPM');
    Map gender = AppConstant.listGender.firstWhere(
      (element) => element['id'] == appController.currentUser.value.genderId,
      orElse: () => AppConstant.listGender[0],
    );
    for (final item in appController.listHeartRateModel) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(item.timeStamp ?? 0);
      listOfData.add(
        [
          DateFormat('MMM dd, yyyy').format(dateTime),
          DateFormat('h:mm a').format(dateTime),
          '${appController.currentUser.value.age ?? 0}',
          chooseContentByLanguage(gender['nameEN'], gender['nameVN']),
          '${item.value}'
        ],
      );
    }
    String csvData = const ListToCsvConverter().convert(
      [
        header,
        ...listOfData,
      ],
    );
    Directory? directoryTemp = await getTemporaryDirectory();
    String? path = '${directoryTemp.path}/${DateTime.now().millisecondsSinceEpoch}.csv';
    final bytes = utf8.encode(csvData);
    Uint8List bytes2 = Uint8List.fromList(bytes);
    await File(path).writeAsBytes(bytes2);
    Share.shareXFiles([XFile(path)]);
    await Future.delayed(const Duration(seconds: 1));
    isExporting.value = false;
  }

  void _generateDataChart() {
    List<Map> listDataChart = [];
    Map mapGroupData = groupBy(
      appController.listHeartRateModel,
      (item) => DateFormat('dd/MM/yyyy').format(
        DateTime.fromMillisecondsSinceEpoch(item.timeStamp ?? 0),
      ),
    );
    DateTime? minDate;
    DateTime? maxDate;
    mapGroupData.forEach((key, value) {
      DateTime handleDate = DateFormat('dd/MM/yyyy').parse(key);
      if (minDate == null || minDate!.isAfter(handleDate)) {
        minDate = handleDate;
      }
      if (maxDate == null || maxDate!.isBefore(handleDate)) {
        maxDate = handleDate;
      }
      if (((value ?? []) as List).isNotEmpty) {
        HeartRateModel heartRateModelData = value[0];
        for (HeartRateModel item in value) {
          if ((item.timeStamp ?? 0) > (heartRateModelData.timeStamp ?? 0)) {
            heartRateModelData = item;
          }
        }
        listDataChart.add(
          {
            'date': handleDate,
            'value': heartRateModelData.value,
            'timeStamp': heartRateModelData.timeStamp,
          },
        );
      }
    });
    appController.chartListData.value = listDataChart;
    if (minDate != null) {
      chartMinDate.value = minDate!;
    }
    if (maxDate != null) {
      chartMaxDate.value = maxDate!;
    }
  }

  void onPressDeleteData() {
    showAppDialog(
      context,
      TranslationConstants.deleteData.tr,
      TranslationConstants.deleteDataConfirm.tr,
      firstButtonText: TranslationConstants.delete.tr,
      firstButtonCallback: () {
        Get.back();
        deleteHeartRateData(currentHeartRateModel.value);
      },
      secondButtonText: TranslationConstants.cancel.tr,
      secondButtonCallback: Get.back,
    );
  }

  void onPressAddAlarm() {
    showAddAlarm(
      context: context,
      alarmType: AlarmType.heartRate,
      onPressSave: (alarmModel) {
        alarmController.addAlarm(alarmModel);
        Get.back();
      },
    );
  }
}
