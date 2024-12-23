import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/constants/app_image.dart';
import '../../../../common/util/disable_glow_behavior.dart';
import '../../../../common/util/translation/app_translation.dart';
import '../../../../domain/model/heart_rate_model.dart';
import '../../../controller/app_controller.dart';
import '../../../theme/app_color.dart';
import '../../../theme/theme_text.dart';
import '../../../widget/app_container.dart';
import '../../../widget/app_header.dart';
import '../../../widget/app_heart_rate_chart_widget.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/app_touchable.dart';
import 'heart_beat_controller.dart';

class HeartBeatScreen extends GetView<HeartBeatController> {
  const HeartBeatScreen({super.key});

  Widget _buildChart() {
    return Padding(
      padding: EdgeInsets.only(
        right: 12.0.sp,
        top: 12.0.sp,
      ),
      child: Obx(
        () => AppHeartRateChartWidget(
          listChartData: Get.find<AppController>().chartListData,
          minDate: controller.chartMinDate.value,
          maxDate: controller.chartMaxDate.value,
          selectedX: controller.chartSelectedX.value,
          onPressDot: (x, dateTime) {
            controller.chartSelectedX.value = x;
            HeartRateModel? checkedHeartRateModel;
            for (final item in Get.find<AppController>().chartListData) {
              if (dateTime.isAtSameMomentAs(item['date'])) {
                checkedHeartRateModel = Get.find<AppController>().listHeartRateModelAll.firstWhere(
                      (element) => item['timeStamp'] == element.timeStamp,
                    );
                break;
              }
            }

            if (checkedHeartRateModel?.timeStamp != controller.currentHeartRateModel.value.timeStamp) {
              controller.currentHeartRateModel.value = checkedHeartRateModel!;
            }
          },
        ),
      ),
    );
  }

  Widget _buildBodyEmpty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppImageWidget.asset(
          path: AppImage.heart_rate_lottie,
          width: Get.width / 3,
          height: Get.width / 3,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.sp),
          child: Text(
            TranslationConstants.measureNowOrAdd.tr,
            textAlign: TextAlign.center,
            style: textStyle20700().merge(
              TextStyle(
                color: AppColor.black,
                fontSize: 16.0.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBodyData() {
    return Column(
      children: [
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: 8.0.sp),
          margin: EdgeInsets.symmetric(
            horizontal: 12.0.sp,
            vertical: 12.0.sp,
          ),
          decoration: commonDecoration(),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      TranslationConstants.average.tr,
                      style: textStyle20700().merge(
                        TextStyle(
                          color: AppColor.black,
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        '${controller.hrAvg.value}',
                        style: textStyle20700().merge(
                          TextStyle(
                            color: AppColor.black,
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      TranslationConstants.min.tr,
                      style: textStyle20700().merge(
                        TextStyle(
                          color: AppColor.black,
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        '${controller.hrMin.value}',
                        style: textStyle20700().merge(
                          TextStyle(
                            color: AppColor.black,
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      TranslationConstants.max.tr,
                      style: textStyle20700().merge(
                        TextStyle(
                          color: AppColor.black,
                          fontSize: 16.0.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Obx(
                      () => Text(
                        '${controller.hrMax.value}',
                        style: textStyle20700().merge(
                          TextStyle(
                            color: AppColor.black,
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 8.0.sp),
            margin: EdgeInsets.symmetric(horizontal: 12.0.sp),
            decoration: commonDecoration(),
            child: _buildChart(),
          ),
        ),
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(
            horizontal: 12.0.sp,
            vertical: 8.0.sp,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 12.0.sp,
            vertical: 16.0.sp,
          ),
          decoration: commonDecoration(),
          child: Obx(() {
            DateTime dateTime =
                DateTime.fromMillisecondsSinceEpoch(controller.currentHeartRateModel.value.timeStamp ?? 0);
            int value = controller.currentHeartRateModel.value.value ?? 40;
            String status = '';
            Color color = AppColor.primaryColor;
            if (value < 60) {
              status = TranslationConstants.slow.tr;
              color = AppColor.violet;
            } else if (value > 100) {
              status = TranslationConstants.fast.tr;
              color = AppColor.red;
            } else {
              status = TranslationConstants.normal.tr;
              color = AppColor.green;
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('MMM dd, yyyy').format(dateTime),
                      style: textStyle14500(),
                    ),
                    SizedBox(height: 2.0.sp),
                    Text(
                      DateFormat('h:mm a').format(dateTime),
                      style: textStyle14500(),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$value',
                      style: TextStyle(
                        fontSize: 32.0.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.black,
                      ),
                    ),
                    Text(
                      'BPM',
                      style: textStyle14500().merge(
                        const TextStyle(height: 1),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0.sp,
                    vertical: 8.0.sp,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8.0.sp),
                  ),
                  child: Text(
                    status,
                    style: textStyle20700().copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0.sp,
                    ),
                  ),
                ),
                AppTouchable(
                  width: 40.0.sp,
                  height: 40.0.sp,
                  onPressed: controller.onPressDeleteData,
                  child: AppImageWidget.asset(
                    path: AppImage.ic_del,
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: TranslationConstants.heartRate.tr,
            decoration: const BoxDecoration(
              color: AppColor.red,
            ),
            leftWidget: AppTouchable(
              width: 40.0.sp,
              height: 40.0.sp,
              onPressed: Get.back,
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
            ),
            additionSpaceButtonLeft: 40.0.sp,
            titleStyle: const TextStyle(color: AppColor.white),
            extendWidget: AppTouchable(
              height: 40.0.sp,
              width: Get.width,
              margin: EdgeInsets.fromLTRB(12.0.sp, 12.0.sp, 12.0.sp, 0),
              onPressed: controller.onPressDateRange,
              outlinedBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0.sp),
              ),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(8.0.sp),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x80000000),
                    offset: const Offset(0, 0),
                    blurRadius: 4.0.sp,
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 40.0.sp,
                  ),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Obx(
                        () => Text(
                          '${DateFormat('MMM dd, yyyy').format(controller.startDate.value)} - ${DateFormat('MMM dd, yyyy').format(controller.endDate.value)}',
                          textAlign: TextAlign.center,
                          style: textStyle18700().copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AppImageWidget.asset(
                    path: AppImage.ic_filter,
                    width: 40.0.sp,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: const DisableGlowBehavior(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.75,
                      child: Obx(
                        () => controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.red,
                                ),
                              )
                            : Get.find<AppController>().listHeartRateModel.isEmpty
                                ? _buildBodyEmpty()
                                : _buildBodyData(),
                      ),
                    ),
                    AppTouchable.common(
                      onPressed: controller.onPressMeasureNow,
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0.sp,
                      ),
                      backgroundColor: AppColor.green,
                      margin: EdgeInsets.fromLTRB(12.0.sp, 0, 12.0.sp, 12.0.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppImageWidget.asset(
                            path: AppImage.ic_heart_rate,
                            width: 32.0.sp,
                          ),
                          SizedBox(width: 8.0.sp),
                          Text(
                            TranslationConstants.measureNow.tr,
                            style: textStyle18700().copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0.sp,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: AppTouchable.common(
                              onPressed: controller.onPressAddAlarm,
                              backgroundColor: AppColor.gold,
                              padding: EdgeInsets.symmetric(
                                vertical: 12.0.sp,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppImageWidget.asset(
                                    path: AppImage.ic_alarm,
                                    width: 32.0.sp,
                                    height: 32.0.sp,
                                    color: AppColor.black,
                                  ),
                                  SizedBox(
                                    width: 4.0.sp,
                                  ),
                                  Text(
                                    TranslationConstants.setAlarm.tr,
                                    style: textStyle18700().copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.0.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 12.0.sp),
                          Expanded(
                            child: AppTouchable.common(
                              onPressed: controller.onPressAddData,
                              backgroundColor: AppColor.primaryColor,
                              padding: EdgeInsets.symmetric(
                                vertical: 18.0.sp,
                              ),
                              child: Text(
                                '+ ${TranslationConstants.addData.tr}',
                                style: textStyle18700().copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => Get.find<AppController>().listHeartRateModel.isNotEmpty
                          ? AppTouchable.common(
                              onPressed: controller.isExporting.value ? null : controller.onPressExport,
                              padding: EdgeInsets.symmetric(
                                vertical: 16.0.sp,
                              ),
                              backgroundColor: AppColor.green,
                              margin: EdgeInsets.fromLTRB(12.0.sp, 12, 12.0.sp, 12.0.sp),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: controller.isExporting.value
                                        ? SizedBox(
                                            width: 20.0.sp,
                                            height: 20.0.sp,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeCap: StrokeCap.round,
                                                strokeWidth: 3.0.sp,
                                              ),
                                            ),
                                          )
                                        : Text(
                                            TranslationConstants.export.tr,
                                            textAlign: TextAlign.center,
                                            style: textStyle18700().copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom + 12.0.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
