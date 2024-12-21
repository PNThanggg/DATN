import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/constants/app_image.dart';
import '../../../common/util/disable_glow_behavior.dart';
import '../../theme/app_color.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_image_widget.dart';
import '../../widget/app_touchable.dart';
import '../../widget/chat_bubble.dart';
import '../../widget/chat_bubble_typing.dart';
import 'chat_controller.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  Widget _buildChatted() {
    return Column(
      children: [
        SizedBox(height: 14.0.sp),
        _buildSuggest(),
        SizedBox(height: 14.0.sp),
        _buildTextField(),
      ],
    );
  }

  Widget _buildSuggest() {
    var crossAxisSpacing = 12.0.sp;
    var screenWidth = Get.width;
    var crossAxisCount = 2;
    var width = (screenWidth - ((crossAxisCount - 1) * crossAxisSpacing)) / crossAxisCount;
    var cellHeight = 60.0.sp;
    var aspectRatio = width / cellHeight;

    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: 12.0.sp,
          right: 24.0.sp,
        ),
        child: Column(
          children: [
            ChatBubble(
              avatarPath: AppImage.avatarBot,
              text: controller.message,
              bubbleRadius: 40,
              isSender: false,
              showBackgroundAvatar: false,
            ),
            SizedBox(height: 16.0.sp),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 50.0.sp,
                  right: 40.0.sp,
                ),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 16.0.sp,
                    crossAxisSpacing: crossAxisSpacing,
                    childAspectRatio: aspectRatio,
                  ),
                  itemCount: controller.listSuggest.length,
                  itemBuilder: (context, index) {
                    return AppTouchable(
                      onPressed: () => controller.onPressItemSuggest(index),
                      padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDF4FF),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(40.0.sp)),
                      ),
                      child: Text(
                        controller.listSuggest[index],
                        style: TextStyle(
                          color: const Color(0xFF656565),
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0.sp,
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: EdgeInsets.only(
        left: 12.0.sp,
        right: 12.0.sp,
        bottom: 12.0.sp,
      ),
      child: TextField(
        controller: controller.textFieldController,
        autofocus: false,
        onTap: () => controller.onTapTextField(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: 24.0.sp,
            top: 14.0.sp,
            bottom: 14.0.sp,
          ),
          filled: true,
          fillColor: const Color(0xFFF6F8FE),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40.0.sp),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 12.0.sp),
            child: AppTouchable(
              onPressed: () => controller.onPressSend(),
              child: AppImageWidget.asset(
                path: AppImage.icSend,
              ),
            ),
          ),
          hintText: 'Ask something',
          hintStyle: TextStyle(
            fontSize: 16.0.sp,
            color: const Color(0xFF9B9B9B),
            fontWeight: FontWeight.w500,
          ),
        ),
        // onSubmitted: (value) async => controller.onPressSend(),
        minLines: 1,
        maxLines: 3,
        style: TextStyle(
          fontSize: 16.0.sp,
          color: const Color(0xFF9B9B9B),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildChatting() {
    return Column(
      children: [
        Expanded(
          child: Obx(
            () => SingleChildScrollView(
              reverse: true,
              child: ListView.builder(
                shrinkWrap: true,
                controller: controller.listScrollController,
                padding: EdgeInsets.zero,
                itemCount: controller.listMessage.length,
                physics:
                    controller.isTyping.value ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (index == controller.listMessage.length - 1) {
                    if (controller.listMessage[index].isSender) {
                      return Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 12.0.sp,
                            ),
                            child: ChatBubble(
                              text: controller.listMessage[index].messageContent,
                              avatarPath: AppImage.avatarBot,
                              isSender: controller.listMessage[index].isSender,
                              bubbleRadius: 36.0.sp,
                            ),
                          ),
                          Obx(
                            () => controller.isTyping.value
                                ? ChatBubbleTyping(
                                    avatarPath: AppImage.avatarBot,
                                    bubbleRadius: 30.0.sp,
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 12.0.sp,
                                    ),
                                    child: ChatBubble(
                                      text: controller.listMessage[index].messageContent,
                                      avatarPath: AppImage.avatarBot,
                                      isSender: controller.listMessage[index].isSender,
                                      bubbleRadius: 36.0.sp,
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 12.0.sp,
                          ),
                        ],
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: 12.0.sp,
                        ),
                        child: ChatBubble(
                          text: controller.listMessage[index].messageContent,
                          avatarPath: AppImage.avatarBot,
                          isSender: controller.listMessage[index].isSender,
                          bubbleRadius: 36.0.sp,
                        ),
                      );
                    }
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 12.0.sp,
                      ),
                      child: ChatBubble(
                        text: controller.listMessage[index].messageContent,
                        avatarPath: AppImage.avatarBot,
                        isSender: controller.listMessage[index].isSender,
                        bubbleRadius: 36.0.sp,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
        _buildTextField(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      resizeToAvoidBottomInset: true,
      child: Column(
        children: [
          AppHeader(
            title: "AI Health Assistant",
            leftWidget: AppTouchable(
              width: 40.0.sp,
              height: 40.0.sp,
              padding: EdgeInsets.all(2.0.sp),
              onPressed: Get.back,
              outlinedBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.0.sp),
              ),
              child: BackButton(
                color: AppColor.black,
                onPressed: Get.back,
              ),
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: const DisableGlowBehavior(),
              child: Obx(
                () => controller.currentChatStatus.value == ChatStatus.chatted ? _buildChatted() : _buildChatting(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
