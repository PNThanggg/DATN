import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../domain/enum/blood_pressure_type.dart';
import '../../../../../theme/app_color.dart';
import '../../../../../theme/theme_text.dart';

class BloodPressureInfoWidget extends StatelessWidget {
  const BloodPressureInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloodPressureTypesLength = BloodPressureType.values.length;

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        vertical: 8.sp,
        horizontal: 20.sp,
      ),
      itemBuilder: (context, index) {
        final type = BloodPressureType.values[index];
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: 8.sp,
            horizontal: 12.sp,
          ),
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
                type.name,
                style: textStyle20600().copyWith(
                  color: AppColor.white,
                ),
              ),
              Text(
                type.messageRange,
                style: textStyle16400().copyWith(
                  color: AppColor.white,
                ),
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
      itemCount: bloodPressureTypesLength,
    );
  }
}
