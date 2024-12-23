import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/util/app_util.dart';
import '../../../../common/util/translation/app_translation.dart';
import '../../../theme/app_color.dart';
import '../../../theme/theme_text.dart';
import '../../../widget/app_dialog.dart';
import '../../../widget/app_touchable.dart';

class AddDataDialog extends StatelessWidget {
  final RxString rxStrDate;
  final RxString rxStrTime;
  final Widget child;
  final Function() onSelectDate;
  final Function() onSelectTime;
  final Function()? firstButtonOnPressed;
  final bool isEdit;
  final Function()? secondButtonOnPressed;
  final Widget? coverScreenWidget;
  final String? firstButtonText;
  final bool hasScroll;

  const AddDataDialog({
    super.key,
    required this.rxStrDate,
    required this.rxStrTime,
    required this.onSelectDate,
    required this.onSelectTime,
    required this.child,
    this.isEdit = false,
    this.coverScreenWidget,
    this.firstButtonOnPressed,
    this.firstButtonText,
    this.secondButtonOnPressed,
    this.hasScroll = false,
  });

  Widget _buildDateTimeWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.sp),
      child: Row(
        children: [
          Expanded(
            child: AppTouchable(
              onPressed: onSelectDate,
              backgroundColor: AppColor.lightGray,
              padding: EdgeInsets.symmetric(
                vertical: 8.sp,
                horizontal: 4.sp,
              ),
              child: Obx(
                () => Text(
                  rxStrDate.value,
                  style: textStyle18500(),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 12.0.sp,
          ),
          AppTouchable(
            onPressed: onSelectTime,
            backgroundColor: AppColor.lightGray,
            padding: EdgeInsets.symmetric(
              vertical: 8.sp,
              horizontal: 8.sp,
            ),
            child: Obx(
              () => Text(
                rxStrTime.value,
                style: textStyle18500(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      firstButtonText: isEdit ? TranslationConstants.save.tr : TranslationConstants.add.tr,
      firstButtonCallback: () {
        firstButtonOnPressed?.call() ?? Get.back;
      },
      secondButtonText: TranslationConstants.cancel.tr,
      hasScroll: hasScroll,
      secondButtonCallback: () {
        secondButtonOnPressed?.call() ?? Get.back;
      },
      coverScreenWidget: coverScreenWidget,
      widgetBody: InkWell(
        onTap: hideKeyboard,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDateTimeWidget(),
            child,
          ],
        ),
      ),
    );
  }
}
