import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../common/constants/app_constant.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/theme_text.dart';
import '../../../../widget/app_touchable.dart';
import 'filter_state_widget.dart';

class SelectStateDialog extends StatelessWidget {
  final RxString rxSelectedState;
  final Function(String) onSelected;

  const SelectStateDialog({
    super.key,
    required this.rxSelectedState,
    required this.onSelected,
  });

  Widget _buildItemWidget(String stateCode, bool isSelected) {
    return AppTouchable(
      margin: EdgeInsets.only(left: 24.sp, bottom: 8.sp),
      onPressed: () => onSelected(stateCode),
      outlinedBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sp),
      ),
      backgroundColor: isSelected ? AppColor.blue98EB.withOpacity(0.2) : AppColor.transparent,
      padding: EdgeInsets.all(8.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            FilterStateWidget.getState(stateCode),
            style: ThemeText.headline6.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Icon(
            isSelected ? Icons.check_circle_rounded : Icons.circle_rounded,
            size: 20.sp,
            color: isSelected ? AppColor.primaryColor : AppColor.gray,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.sp,
        ),
        Column(
          children: bloodSugarStateCodeList
              .map(
                (e) => Obx(
                  () => _buildItemWidget(
                    e,
                    rxSelectedState.value == e,
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(
          height: 76.sp,
        ),
      ],
    );
  }
}
