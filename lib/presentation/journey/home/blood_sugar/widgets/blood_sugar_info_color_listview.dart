import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../common/constants/app_constant.dart';
import '../add_blood_sugar_dialog/add_blood_sugar_controller.dart';
import 'blood_sugar_color_item_widget.dart';

class BloodSugarInfoListView extends GetWidget<AddBloodSugarController> {
  const BloodSugarInfoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.sp),
      child: Row(
        children: bloodSugarInformationCodeList
            .map(
              (code) => Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => BloodSugarColorItemWidget(
                          infoCode: code,
                          isCurrent: controller.rxInfoCode.value == code,
                        ),
                      ),
                    ),
                    code == bloodSugarInformationCodeList.last
                        ? const SizedBox()
                        : SizedBox(
                            width: 6.sp,
                          )
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
