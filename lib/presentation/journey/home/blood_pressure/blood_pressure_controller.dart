import 'package:collection/collection.dart';
import 'package:datn/common/extensions/int_extension.dart';
import 'package:datn/common/util/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/mixin/alarm_dialog_mixin.dart';
import '../../../../common/mixin/date_time_mixin.dart';
import '../../../../common/util/app_util.dart';
import '../../../../common/util/translation/app_translation.dart';
import '../../../../domain/enum/alarm_type.dart';
import '../../../../domain/model/alarm_model.dart';
import '../../../../domain/model/bar_chart_data_model.dart';
import '../../../../domain/model/blood_pressure_model.dart';
import '../../../../domain/usecase/alarm_usecase.dart';
import '../../../../domain/usecase/blood_pressure_usecase.dart';
import '../../../controller/app_controller.dart';
import '../../../widget/app_dialog.dart';
import '../../alarm/alarm_controller.dart';
import 'add_blood_pressure/add_blood_pressure_dialog.dart';

class BloodPressureController extends GetxController with DateTimeMixin, AlarmDialogMixin {
  late BuildContext context;
  final BloodPressureUseCase _bloodPressureUseCase;
  final AlarmUseCase _alarmUseCase;

  final RxList<BloodPressureModel> bloodPressures = <BloodPressureModel>[].obs;
  final RxList<Map> bloodPressureChartData = <Map>[].obs;
  final RxInt sysMin = 0.obs;
  final RxInt sysMax = 0.obs;
  final RxInt diaMin = 0.obs;
  final RxInt diaMax = 0.obs;
  final RxInt chartGroupIndexSelected = 0.obs;
  final RxInt chartXValueSelected = 0.obs;
  final Rx<DateTime> chartMinDate = DateTime.now().obs;
  final Rx<DateTime> chartMaxDate = DateTime.now().obs;
  final Rx<BloodPressureModel> bloodPressSelected = BloodPressureModel().obs;
  RxBool isExporting = false.obs;

  final AppController appController = Get.find<AppController>();

  BloodPressureController(this._bloodPressureUseCase, this._alarmUseCase);

  @override
  void onInit() {
    filterEndDate.value = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      23,
      59,
      59,
    );
    DateTime temp = filterEndDate.value.subtract(
      const Duration(days: 7),
    );
    filterStartDate.value = DateTime(temp.year, temp.month, temp.day);
    filterBloodPressure();
    super.onInit();
  }

  void onSetAlarm() {
    // if (Platform.isIOS) {
    //   showInterstitialAds(() {
    //     showAddAlarm(
    //         context: context,
    //         alarmType: AlarmType.bloodPressure,
    //         onPressCancel: Get.back,
    //         onPressSave: _onSaveAlarm);
    //   });
    // } else {
    //   showAddAlarm(
    //       context: context,
    //       alarmType: AlarmType.bloodPressure,
    //       onPressCancel: Get.back,
    //       onPressSave: _onSaveAlarm);
    // }

    showAddAlarm(
      context: context,
      alarmType: AlarmType.bloodPressure,
      onPressCancel: Get.back,
      onPressSave: _onSaveAlarm,
    );
  }

  Future<void> _onSaveAlarm(AlarmModel alarm) async {
    _alarmUseCase.addAlarm(alarm);
    Get.find<AlarmController>().refresh();
    Get.back();
  }

  Future<void> onAddData() async {
    final result = await showAppDialog(
      context,
      "",
      "",
      builder: (ctx) => const AddBloodPressureDialog(),
    );
    if (result != null && result) {
      filterBloodPressure();
    }
    appController.setAllowBloodPressureFirstTime(false);
  }

  Future filterBloodPressure() async {
    bloodPressureChartData.clear();
    final result = _bloodPressureUseCase.filterBloodPressureDate(
      filterStartDate.value.millisecondsSinceEpoch,
      filterEndDate.value.millisecondsSinceEpoch,
    );
    result.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
    bloodPressures.value = result;

    if (bloodPressures.isNotEmpty) {
      bloodPressSelected.value = bloodPressures.last;
      chartXValueSelected.value = bloodPressSelected.value.dateTime!.getMillisecondDateFormat('dd/MM/yyyy');
      chartMinDate.value = DateTime.fromMillisecondsSinceEpoch(result.first.dateTime!);
      chartMaxDate.value = DateTime.fromMillisecondsSinceEpoch(result.last.dateTime!);
      final mapGroupData = groupBy(bloodPressures,
          (p0) => DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(p0.dateTime ?? 0)));
      if (mapGroupData.isNotEmpty) {
        final lastKey = mapGroupData.keys.last;
        final lastValue = mapGroupData[lastKey];
        if (lastValue != null && lastValue.isNotEmpty) {
          chartGroupIndexSelected.value = (lastValue.length) - 1;
        }
      }
      mapGroupData.forEach((key, value) {
        final handleDate = DateFormat('dd/MM/yyyy').parse(key);
        final dataList = <BarChartDataModel>[];
        if (value.isNotEmpty) {
          for (final item in value) {
            sysMin.value = item.systolic ?? 0;
            sysMax.value = item.systolic ?? 0;
            diaMax.value = item.diastolic ?? 0;
            diaMin.value = item.diastolic ?? 0;
            dataList.add(
              BarChartDataModel(
                fromY: item.diastolic?.toDouble() ?? 0.0,
                toY: item.systolic?.toDouble() ?? 0.0,
              ),
            );
          }
          bloodPressureChartData.add({"dateTime": handleDate.millisecondsSinceEpoch, "values": dataList});
        }
      });
    }
  }

  void onSelectedBloodPress(int dateTime, int groupIndex) {
    chartGroupIndexSelected.value = groupIndex;
    chartXValueSelected.value = dateTime;
    final tempData = bloodPressures
        .where((element) => element.dateTime!.getMillisecondDateFormat('dd/MM/yyyy') == dateTime)
        .toList();
    if (tempData.isNotEmpty && tempData.length > groupIndex) {
      bloodPressSelected.value = tempData[groupIndex];
    }
  }

  void onPressDeleteData() {
    _bloodPressureUseCase.deleteBloodPressure(bloodPressSelected.value.key!);
    showSnackBar(
      context,
      subtitle: TranslationConstants.deleteDataSuccess.tr,
      type: SnackBarType.success,
    );
    filterBloodPressure();
  }

  Future<void> onEdit() async {
    final result = await showAppDialog(
      context,
      "",
      "",
      builder: (ctx) => AddBloodPressureDialog(
        bloodPressureModel: bloodPressSelected.value,
      ),
    );
    if (result != null && result) {
      filterBloodPressure();
    }
  }

  Future<void> onExportData() async {
    isExporting.value = true;
    List<String> header = [];
    List<List<String>> listOfData = [];
    header.add(TranslationConstants.date.tr);
    header.add(TranslationConstants.time.tr);
    header.add(TranslationConstants.systolic.tr);
    header.add(TranslationConstants.diastolic.tr);
    header.add(TranslationConstants.pulse.tr);
    header.add(TranslationConstants.type.tr);
    for (final item in bloodPressures) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(item.dateTime ?? 0);
      listOfData.add(
        [
          DateFormat('MMM dd, yyyy').format(dateTime),
          DateFormat('h:mm a').format(dateTime),
          '${item.systolic ?? 0}',
          '${item.diastolic ?? 0}',
          '${item.pulse ?? 0}',
          item.bloodType.name
        ],
      );
    }
    await exportFile(header, listOfData);
    isExporting.value = false;
  }
}
