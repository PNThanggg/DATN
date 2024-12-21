import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../common/constants/app_image.dart';
import '../../../../../theme/app_color.dart';
import '../../../../../theme/theme_text.dart';
import '../../../../../widget/app_image_widget.dart';
import '../../../../../widget/app_touchable.dart';

class UnitButton extends StatelessWidget {
  final double? width;
  final Function()? onPressed;
  final String value;

  const UnitButton({
    super.key,
    this.width,
    this.onPressed,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      width: width,
      onPressed: onPressed,
      backgroundColor: AppColor.lightGray,
      padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 12.sp),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                value,
                style: textStyle18500(),
              ),
            ),
          ),
          AppImageWidget.asset(
            path: AppImage.ic_arrow_2,
            height: 20.sp,
          )
        ],
      ),
    );
  }
}
