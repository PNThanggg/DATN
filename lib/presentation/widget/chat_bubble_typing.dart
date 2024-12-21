import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/constants/app_image.dart';
import 'app_image_widget.dart';

class ChatBubbleTyping extends StatelessWidget {
  final double bubbleRadius;
  final String avatarPath;

  const ChatBubbleTyping({
    super.key,
    required this.avatarPath,
    this.bubbleRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 12.0.sp,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppImageWidget.asset(
            path: avatarPath,
            height: 40.0.sp,
          ),
          Container(
            width: 50.0.sp,
            height: 40.0.sp,
            margin: EdgeInsets.symmetric(
              horizontal: 12.0.sp,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.all(
                Radius.circular(bubbleRadius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppImageWidget.asset(
                  path: AppImage.loadingTyping,
                  height: 40.0.sp,
                  width: 40.0.sp,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
