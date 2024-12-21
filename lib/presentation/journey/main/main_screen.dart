import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/constants/app_image.dart';
import '../../../common/util/translation/app_translation.dart';
import '../../theme/app_color.dart';
import '../../widget/app_container.dart';
import '../../widget/app_image_widget.dart';
import '../alarm/alarm_screen.dart';
import '../alarm/widgets/alarm_add_button.dart';
import '../home/home_screen.dart';
import '../insight/insight_screen.dart';
import 'main_controller.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      alignLayer: AlignmentDirectional.bottomEnd,
      coverScreenWidget: Obx(
        () {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 260),
            child: controller.currentTab.value != 2 ? const SizedBox.shrink() : const AddAlarmButton(),
          );
        },
      ),
      child: Scaffold(
        body: Obx(() {
          return IndexedStack(
            index: controller.currentTab.value,
            children: const [
              HomeScreen(),
              InsightScreen(),
              AlarmScreen(),
            ],
          );
        }),
        bottomNavigationBar: Obx(() {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColor.red,
            onTap: controller.onPressTab,
            currentIndex: controller.currentTab.value,
            unselectedItemColor: AppColor.white.withOpacity(0.5),
            unselectedFontSize: 12.0.sp,
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            selectedItemColor: AppColor.white,
            selectedFontSize: 12.0.sp,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            items: [
              BottomNavigationBarItem(
                icon: AppImageWidget.asset(
                  path: AppImage.ic_home,
                  color: controller.currentTab.value == 0 ? AppColor.white : AppColor.white.withOpacity(0.5),
                ),
                label: TranslationConstants.home.tr.toUpperCase(),
              ),
              BottomNavigationBarItem(
                icon: AppImageWidget.asset(
                  path: AppImage.ic_insight,
                  color: controller.currentTab.value == 1 ? AppColor.white : AppColor.white.withOpacity(0.5),
                ),
                label: TranslationConstants.insights.tr.toUpperCase(),
              ),
              BottomNavigationBarItem(
                icon: AppImageWidget.asset(
                  path: AppImage.ic_alarm,
                  color: controller.currentTab.value == 2 ? AppColor.white : AppColor.white.withOpacity(0.5),
                ),
                label: TranslationConstants.alarm.tr.toUpperCase(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
