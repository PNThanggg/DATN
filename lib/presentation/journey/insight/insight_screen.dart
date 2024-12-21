import 'package:datn/common/util/disable_glow_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/util/translation/app_translation.dart';
import '../../theme/app_color.dart';
import '../../theme/theme_text.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/app_touchable.dart';
import 'insight_controller.dart';
import 'insight_details_screen.dart';

class InsightScreen extends GetView<InsightController> {
  const InsightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: TranslationConstants.insights.tr,
            leftWidget: SizedBox(width: 40.0.sp),
            titleStyle: const TextStyle(fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: Obx(
              () {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                return ScrollConfiguration(
                  behavior: const DisableGlowBehavior(),
                  child: ListView.builder(
                    padding: EdgeInsets.zero.copyWith(
                      top: 16.0.sp,
                      bottom: 16.0.sp,
                    ),
                    itemCount: controller.insightList.value.length,
                    itemBuilder: (context, index) {
                      final Map<String, dynamic> content = controller.insightList[index];

                      return AppTouchable.common(
                        onPressed: () {
                          Get.to(
                            () => InsightDetails(
                              title: content["title"],
                              iconPath: content["icon"],
                              contents: (content["content"] as List).cast<String>(),
                            ),
                          );
                        },
                        margin: EdgeInsets.symmetric(
                          horizontal: 12.0.sp,
                          vertical: 6.0.sp,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.0.sp,
                          vertical: 12.0.sp,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 0),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        width: Get.width,
                        child: Row(
                          children: [
                            AppImageWidget.asset(
                              path: content["icon"],
                              width: 48.0.sp,
                            ),
                            SizedBox(
                              width: 12.0.sp,
                            ),
                            Expanded(
                              child: Text(
                                content["title"],
                                style: textStyle20700().copyWith(
                                  color: AppColor.black,
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: null,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
