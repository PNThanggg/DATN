import 'package:datn/domain/enum/bmi_type.dart';
import 'package:datn/domain/enum/height_unit.dart';
import 'package:datn/domain/enum/weight_unit.dart';
import 'package:datn/presentation/journey/home/weight_bmi/add_weight_bmi/widget/unit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../common/constants/app_image.dart';
import '../../../../../common/util/app_util.dart';
import '../../../../../common/util/format_utils.dart';
import '../../../../../common/util/translation/app_translation.dart';
import '../../../../../domain/model/bmi_model.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/theme_text.dart';
import '../../../../widget/app_image_widget.dart';
import '../../../../widget/app_loading.dart';
import '../../../../widget/app_touchable.dart';
import '../../widget/add_data_widget.dart';
import '../../widget/blood_text_field_widget.dart';
import 'add_weight_bmi_controller.dart';

class AddWeightBMIDialog extends GetView<AddWeightBMIController> {
  final BMIModel? bmiModel;

  const AddWeightBMIDialog({
    super.key,
    this.bmiModel,
  });

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    if (bmiModel != null) {
      controller.onEdit(bmiModel!);
    }

    return AddDataDialog(
      rxStrDate: controller.stringBloodPrDate,
      rxStrTime: controller.stringBloodPrTime,
      onSelectDate: controller.onSelectBMIDate,
      isEdit: bmiModel != null,
      hasScroll: true,
      onSelectTime: controller.onSelectBMITime,
      secondButtonOnPressed: () => Get.back(),
      firstButtonOnPressed: bmiModel != null ? controller.onSave : controller.addBMI,
      coverScreenWidget: Obx(
        () => controller.isLoading.value ? const AppLoading() : const SizedBox(),
      ),
      child: Column(
        children: [
          SizedBox(height: 24.sp),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => UnitButton(
                    value: '${TranslationConstants.weight.tr} '
                        '(${controller.weightUnit.value.label})',
                    onPressed: controller.onSelectWeightUnit,
                  ),
                ),
              ),
              SizedBox(width: 16.sp),
              Expanded(
                child: Obx(
                  () => UnitButton(
                    value: '${TranslationConstants.height.tr} '
                        '(${controller.heightUnit.value.label})',
                    onPressed: controller.onSelectHeightUnit,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.sp),
          SizedBox(
            height: 68.sp,
            child: Row(
              children: [
                Expanded(
                  child: BloodTextFieldWidget(
                    controller: controller.weightController,
                    onChanged: controller.caculateBMI,
                  ),
                ),
                SizedBox(
                  width: 16.sp,
                ),
                Expanded(
                  child: Obx(() {
                    if (controller.heightUnit.value == HeightUnit.cm) {
                      return BloodTextFieldWidget(
                        controller: controller.cmController,
                        onChanged: controller.caculateBMI,
                      );
                    } else {
                      return Row(
                        children: [
                          Expanded(
                            child: BloodTextFieldWidget(
                              controller: controller.ftController,
                              onChanged: controller.caculateBMI,
                              inputFormatters: [
                                FeetFormatter(),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8.sp,
                          ),
                          Expanded(
                            child: BloodTextFieldWidget(
                              controller: controller.inchController,
                              onChanged: controller.caculateBMI,
                              inputFormatters: [
                                InchesFormatter(),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 48.sp,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: controller.bmiType.value.color,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Text(
                    controller.bmiType.value.bmiName,
                    style: textStyle20600().copyWith(
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16.sp,
              ),
              Obx(
                () => AppTouchable(
                  onPressed: controller.onShowInfo,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    color: AppColor.lightGray,
                    borderRadius: BorderRadius.all(
                      Radius.circular(9),
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    controller.bmiType.value.message,
                    style: textStyle16400().copyWith(
                      color: AppColor.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 28.sp,
          ),
          Obx(
            () => Row(
              children: BMIType.values
                  .map(
                    (e) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.sp),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            controller.bmiType.value == e
                                ? AppImageWidget.asset(
                                    path: AppImage.ic_down,
                                    width: 20.0.sp,
                                    height: 12.sp,
                                    color: controller.bmiType.value.color,
                                  )
                                : SizedBox(
                                    height: 12.sp,
                                  ),
                            SizedBox(
                              height: 4.sp,
                            ),
                            Container(
                              height: 12.sp,
                              decoration: BoxDecoration(
                                color: e.color,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          SizedBox(
            height: 30.sp,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTouchable(
                onPressed: controller.onPressedAge,
                padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 12.0.sp),
                child: Obx(() => Text(
                      '${TranslationConstants.age.tr}: ${controller.age.value}',
                      style: textStyle18400().merge(const TextStyle(
                        shadows: [Shadow(color: AppColor.grayText2, offset: Offset(0, -5))],
                        color: Colors.transparent,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.grayText2,
                      )),
                    )),
              ),
              SizedBox(width: 12.0.sp),
              AppTouchable(
                onPressed: controller.onPressGender,
                padding: EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 12.0.sp),
                child: Obx(() {
                  return Text(
                    chooseContentByLanguage(controller.gender['nameEN'], controller.gender['nameVN']),
                    style: textStyle18400().merge(const TextStyle(
                      shadows: [Shadow(color: AppColor.grayText2, offset: Offset(0, -5))],
                      color: Colors.transparent,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.grayText2,
                    )),
                  );
                }),
              ),
            ],
          ),
          SizedBox(
            height: 36.sp,
          )
        ],
      ),
    );
  }
}
