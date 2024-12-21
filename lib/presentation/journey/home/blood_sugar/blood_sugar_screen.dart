import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/constants/app_image.dart';
import '../../../../common/constants/enums.dart';
import '../../../../common/util/translation/app_translation.dart';
import '../../../theme/app_color.dart';
import '../../../widget/app_container.dart';
import '../../../widget/app_dialog.dart';
import '../../../widget/blood_header_widget.dart';
import '../../../widget/filter/filter_date_widget.dart';
import '../widget/alarm_add_data_button.dart';
import '../widget/empty_widget.dart';
import 'blood_sugar_controller.dart';
import 'widgets/blood_sugar_data_widget.dart';
import 'widgets/filter_state_widget.dart';
import 'widgets/select_state_dialog.dart';

Future showStateDialog(BuildContext context, Function(String) onSelected, RxString rxSelectedState) => showAppDialog(
      context,
      TranslationConstants.bloodSugarState.tr,
      '',
      widgetBody: SelectStateDialog(
        onSelected: onSelected,
        rxSelectedState: rxSelectedState,
      ),
      firstButtonText: 'OK',
    );

class BloodSugarScreen extends GetView<BloodSugarController> {
  const BloodSugarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return AppContainer(
      child: Column(
        children: [
          Obx(
            () => BloodHeaderWidget(
              title: TranslationConstants.bloodSugar.tr,
              background: AppColor.deepViolet,
              onExported: controller.onExportData,
              extendWidget: Column(
                children: [
                  Obx(
                    () => FilterDateWidget(
                      startDate: controller.filterStartDate.value,
                      endDate: controller.filterEndDate.value,
                      onPressed: controller.onSelectedDateTime,
                    ),
                  ),
                  const FilterStateWidget(),
                ],
              ),
              isLoading: controller.exportLoaded.value == LoadedType.start,
            ),
          ),
          Expanded(
            child: Obx(
              () {
                if (controller.rxIsEmptyList.value == false) {
                  return const BloodSugarDataWidget();
                }
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  child: EmptyWidget(
                    imagePath: AppImage.ic_blood_sugar_empty_data,
                    imageWidth: 120.sp,
                    message: TranslationConstants.addYourRecordToSeeStatistics.tr,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.sp),
            child: AlarmAddDataButton(
              onSetAlarm: controller.onSetAlarm,
              onAddData: controller.onAddData,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom + 16.sp,
          )
        ],
      ),
    );
  }
}
