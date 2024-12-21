import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'animated_text/animated_text_kit.dart';
import 'app_image_widget.dart';

const double BUBBLE_RADIUS = 40;

class ChatBubble extends StatelessWidget {
  final double bubbleRadius;
  final bool isSender;
  final String text;
  final bool tail;
  final bool sent;
  final bool delivered;
  final bool seen;
  final TextStyle? textStyle;
  final String avatarPath;
  final EdgeInsets? padding, margin;
  final bool showBackgroundAvatar;
  final Function()? onPressed;

  const ChatBubble({
    super.key,
    required this.text,
    this.bubbleRadius = BUBBLE_RADIUS,
    this.isSender = true,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
    this.textStyle,
    required this.avatarPath,
    this.padding,
    this.margin,
    this.showBackgroundAvatar = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0.sp,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          isSender
              ? const SizedBox.shrink()
              : showBackgroundAvatar
                  ? Container(
                      height: 45.0.sp,
                      width: 45.0.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0.sp),
                        ),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF824A97).withOpacity(0.4),
                            const Color(0xFF824A97).withOpacity(0.4),
                            const Color(0xFF4221A0).withOpacity(0.4),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(top: 4.0.sp),
                        child: AppImageWidget.asset(
                          path: avatarPath,
                          height: 40.0.sp,
                        ),
                      ),
                    )
                  : AppImageWidget.asset(
                      path: avatarPath,
                      height: 40.0.sp,
                    ),
          Container(
            width: Get.width,
            constraints: BoxConstraints(maxWidth: Get.width * 0.7),
            decoration: BoxDecoration(
              color: isSender ? const Color(0xFFF3F3F3) : const Color(0xFF008EFF),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(bubbleRadius),
                topRight: Radius.circular(bubbleRadius),
                bottomLeft: Radius.circular(
                  tail
                      ? isSender
                          ? bubbleRadius
                          : 0
                      : BUBBLE_RADIUS,
                ),
                bottomRight: Radius.circular(
                  tail
                      ? isSender
                          ? 0
                          : bubbleRadius
                      : BUBBLE_RADIUS,
                ),
              ),
            ),
            margin: isSender
                ? EdgeInsets.only(
                    right: 30.0.sp,
                  )
                : EdgeInsets.only(
                    left: 12.0.sp,
                  ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 24.0.sp,
                bottom: 24.0.sp,
                left: 20.0.sp,
                right: 20.0.sp,
              ),
              child: isSender
                  ? Text(
                      text,
                      style: textStyle ??
                          TextStyle(
                            color: const Color(0xFF656565),
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.w400,
                          ),
                      textAlign: TextAlign.left,
                    )
                  : AnimatedTextWidget(
                      isRepeatingAnimation: false,
                      repeatForever: false,
                      displayFullTextOnTap: true,
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TyperAnimatedText(
                          text.trim(),
                          textStyle: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
