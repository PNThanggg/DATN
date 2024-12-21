import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/enum/alarm_type.dart';
import '../../../theme/app_color.dart';
import '../../../widget/app_floating_action_bubble.dart';
import 'alarm_add_button_controller.dart';

class AddAlarmButton extends GetView<AlarmAddButtonController> {
  const AddAlarmButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedFloatingActionButton(
      animation: controller.animation,
      onPress: () => controller.animationController.isCompleted
          ? controller.animationController.reverse()
          : controller.animationController.forward(),
      iconColor: AppColor.white,
      backgroundCloseColor: AppColor.primaryColor,
      items: AlarmType.values
          .map(
            (alarmType) => Bubble(
              title: alarmType.tr,
              bubbleColor: alarmType.color,
              onPress: () {
                controller.onPressAdd(context, alarmType);
              },
            ),
          )
          .toList(),
    );
  }
}
