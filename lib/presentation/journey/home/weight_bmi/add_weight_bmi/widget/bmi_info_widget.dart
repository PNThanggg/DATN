import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../common/util/translation/app_translation.dart';
import '../../../../../../domain/enum/bmi_type.dart';
import '../../../../../theme/app_color.dart';
import '../../../../../theme/theme_text.dart';
import '../../../../../widget/app_button.dart';

class BMIINfoWidget extends StatelessWidget {
  const BMIINfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bmiTypeLength = BMIType.values.length;
    double width = MediaQuery.of(context).size.width;
    var dialogWidth = min<double>(width * 0.86, 400);
    return Container(
      width: dialogWidth,
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.all(10.0.sp),
      margin: EdgeInsets.symmetric(vertical: 20.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            TranslationConstants.bmi.tr,
            textAlign: TextAlign.center,
            style: textStyle20700().merge(
              const TextStyle(
                color: AppColor.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
                itemBuilder: (context, index) {
                  final type = BMIType.values[index];
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
                    decoration: BoxDecoration(
                      color: type.color,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type.bmiName,
                          style: textStyle20600().copyWith(color: AppColor.white),
                        ),
                        Text(
                          type.message,
                          style: textStyle16400().copyWith(color: AppColor.white),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20.sp,
                  );
                },
                itemCount: bmiTypeLength),
          ),
          AppButton(
            height: 60.0.sp,
            width: Get.width,
            onPressed: Get.back,
            color: AppColor.primaryColor,
            radius: 10.0.sp,
            child: Text(
              TranslationConstants.ok.tr,
              textAlign: TextAlign.center,
              style: textStyle24700(),
            ),
          ),
        ],
      ),
    );
  }
}
