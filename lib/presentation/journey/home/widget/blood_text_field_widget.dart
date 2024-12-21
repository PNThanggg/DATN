import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_color.dart';
import '../../../theme/theme_text.dart';

class BloodTextFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Function()? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const BloodTextFieldWidget({
    super.key,
    this.controller,
    this.onChanged,
    this.inputFormatters,
  });

  @override
  State<StatefulWidget> createState() => _BloodTextFieldWidgetState();
}

class _BloodTextFieldWidgetState extends State<BloodTextFieldWidget> {
  final FocusNode focus = FocusNode();

  @override
  void initState() {
    super.initState();
    focus.addListener(() {
      if (focus.hasFocus == false) {
        if (widget.onChanged != null) {
          widget.onChanged!();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.lightGray,
      borderRadius: BorderRadius.circular(9.sp),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9.sp),
        child: Center(
          child: TextFormField(
            focusNode: focus,
            controller: widget.controller,
            cursorColor: AppColor.primaryColor,
            textAlign: TextAlign.center,
            maxLines: null,
            expands: true,
            inputFormatters: widget.inputFormatters,
            style: ThemeText.headline4.copyWith(
              fontSize: 30.sp,
              fontWeight: FontWeight.w600,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) => widget.onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.lightGray,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 16.sp),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
