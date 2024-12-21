import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/util/translation/app_translation.dart';
import '../theme/app_color.dart';
import '../theme/theme_text.dart';
import 'app_button.dart';
import 'app_touchable.dart';

class AppDialogLanguageWidget extends StatefulWidget {
  const AppDialogLanguageWidget({
    super.key,
    required this.availableLocales,
    required this.initialLocale,
    required this.onLocaleSelected,
    required this.onPressCancel,
  });

  final List<Locale> availableLocales;
  final Locale initialLocale;
  final void Function(Locale) onLocaleSelected;
  final void Function() onPressCancel;

  @override
  State<AppDialogLanguageWidget> createState() =>
      _AppDialogLanguageWidgetState();
}

class _AppDialogLanguageWidgetState extends State<AppDialogLanguageWidget> {
  Locale? _currentLocale;

  @override
  void initState() {
    _currentLocale = widget.initialLocale;
    super.initState();
  }

  void _onLocaleSelected(Locale locale) {
    setState(() {
      _currentLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 102.sp,
        ),

        for (Locale locale in widget.availableLocales)
          AppTouchable(
            onPressed: () => _onLocaleSelected(locale),
            child: Container(
              width: double.infinity,
              padding:
                  EdgeInsets.symmetric(vertical: 8.0.sp, horizontal: 10.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0.sp),
                color: _currentLocale == locale
                    ? AppColor.primaryColor.withOpacity(0.2)
                    : AppColor.white,
              ),
              child: Row(
                children: [
                  Text(
                    locale.languageCode.tr,
                    style: TextStyle(
                      color: _currentLocale == locale
                          ? AppColor.primaryColor
                          : AppColor.black,
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    _currentLocale == locale
                        ? Icons.check_circle
                        : Icons.circle,
                    color: _currentLocale == locale
                        ? AppColor.primaryColor
                        : AppColor.gray,
                  ),
                ],
              ),
            ),
          ),
        SizedBox(
          height: 102.sp,
        ),
        Row(
          children: [
            Expanded(
              child: AppButton(
                onPressed: widget.onPressCancel,
                height: 60.0.sp,
                width: Get.width,
                color: AppColor.red,
                radius: 10.0.sp,
                child: Text(
                  TranslationConstants.cancel.tr,
                  textAlign: TextAlign.center,
                  style: textStyle24700(),
                ),
              ),
            ),
            SizedBox(width: 8.0.sp),
            Expanded(
              child: AppButton(
                height: 60.0.sp,
                width: Get.width,
                onPressed: () => widget.onLocaleSelected(_currentLocale!),
                color: AppColor.primaryColor,
                radius: 10.0.sp,
                child: Text(
                  TranslationConstants.save.tr,
                  textAlign: TextAlign.center,
                  style: textStyle24700(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
