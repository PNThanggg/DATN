import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/util/disable_glow_behavior.dart';
import '../../theme/app_color.dart';
import '../../theme/theme_text.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/app_touchable.dart';

class InsightDetails extends StatelessWidget {
  const InsightDetails({
    super.key,
    required this.title,
    required this.iconPath,
    required this.contents,
  });

  final String title;
  final List<String> contents;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            leftWidget: AppTouchable.common(
              onPressed: () => Get.back(),
              decoration: const BoxDecoration(boxShadow: null),
              child: BackButton(
                color: AppColor.black,
                onPressed: Get.back,
              ),
            ),
            title: title,
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: const DisableGlowBehavior(),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.0.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppImageWidget.asset(
                        path: iconPath,
                        height: 100.0.sp,
                      ),
                      SizedBox(
                        height: 24.0.sp,
                      ),
                      Text(
                        "${contents[0]}\n",
                        style: textStyle16400().copyWith(
                          fontSize: 12.0.sp,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      ...contents.sublist(1).map(
                            (e) => Text(
                              "   $e\n",
                              style: textStyle16400().copyWith(
                                fontSize: 12.0.sp,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
