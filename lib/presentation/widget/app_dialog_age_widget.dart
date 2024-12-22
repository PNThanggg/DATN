import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/util/disable_glow_behavior.dart';
import '../../common/util/translation/app_translation.dart';
import '../theme/app_color.dart';
import '../theme/theme_text.dart';
import 'app_button.dart';

class AppDialogAgeWidget extends StatefulWidget {
  final int? initialAge;
  final Function()? onPressCancel;
  final Function(int value)? onPressSave;

  const AppDialogAgeWidget({
    super.key,
    this.initialAge,
    this.onPressCancel,
    this.onPressSave,
  });

  @override
  State<AppDialogAgeWidget> createState() => _AppDialogAgeWidgetState();
}

class _AppDialogAgeWidgetState extends State<AppDialogAgeWidget> {
  late FixedExtentScrollController fixedExtentScrollController;
  late int _value;

  @override
  void initState() {
    fixedExtentScrollController = FixedExtentScrollController(initialItem: (widget.initialAge ?? 30) - 2);
    _value = widget.initialAge ?? 30;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100.0.sp,
          height: 180.0.sp,
          margin: EdgeInsets.symmetric(vertical: 24.0.sp),
          child: ScrollConfiguration(
            behavior: const DisableGlowBehavior(),
            child: CupertinoPicker.builder(
              scrollController: fixedExtentScrollController,
              childCount: 109,
              itemExtent: 60.0.sp,
              onSelectedItemChanged: (value) {
                _value = value + 2;
              },
              selectionOverlay: Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: const Color(0xFFCACACA),
                      width: 2.0.sp,
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, value) {
                return Center(
                  child: Text(
                    '${value + 2}',
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 40.0.sp,
                      fontWeight: FontWeight.w700,
                      height: 5 / 4,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: AppButton(
                onPressed: widget.onPressCancel,
                padding: EdgeInsets.symmetric(
                  vertical: 12.0.sp,
                ),
                color: AppColor.red,
                radius: 10.0.sp,
                child: Text(
                  TranslationConstants.cancel.tr,
                  textAlign: TextAlign.center,
                  style: textStyle20700().merge(
                    TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.0.sp),
            Expanded(
              child: AppButton(
                padding: EdgeInsets.symmetric(
                  vertical: 12.0.sp,
                ),
                onPressed: () => widget.onPressSave!(_value),
                color: AppColor.primaryColor,
                radius: 10.0.sp,
                child: Text(
                  TranslationConstants.save.tr,
                  textAlign: TextAlign.center,
                  style: textStyle20700().merge(
                    TextStyle(
                      color: AppColor.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
