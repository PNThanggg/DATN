import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/constants/app_image.dart';
import '../../theme/app_color.dart';
import '../../theme/theme_text.dart';
import '../app_image_widget.dart';
import '../app_touchable.dart';

class FilterWidget extends StatelessWidget {
  final Function()? onPressed;
  final String title;

  const FilterWidget({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      height: 40.0.sp,
      width: Get.width,
      margin: EdgeInsets.fromLTRB(27.0.sp, 14.0.sp, 27.0.sp, 0),
      onPressed: onPressed,
      outlinedBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(87.0.sp),
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(87.0.sp),
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
          SizedBox(width: 44.0.sp),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: textStyle18400(),
              ),
            ),
          ),
          AppImageWidget.asset(
            path: AppImage.ic_filter,
            width: 40.0.sp,
          ),
          SizedBox(width: 4.0.sp),
        ],
      ),
    );
  }
}
