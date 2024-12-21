import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../theme/app_color.dart';
import '../theme/theme_text.dart';
import 'app_touchable.dart';

class AnimatedFloatingActionButton extends AnimatedWidget {
  const AnimatedFloatingActionButton({
    super.key,
    required this.items,
    required this.onPress,
    required this.iconColor,
    this.backgroundCloseColor = AppColor.white,
    this.backgroundOpenColor = AppColor.gold,
    required Animation animation,
    this.herotag,
    this.iconData,
    this.animatedIconData,
  }) : super(listenable: animation);

  final List<Bubble> items;
  final void Function() onPress;
  final AnimatedIconData? animatedIconData;
  final Object? herotag;
  final Widget? iconData;
  final Color iconColor;
  final Color backgroundCloseColor;
  final Color backgroundOpenColor;

  get _animation => listenable;

  Widget buildItem(BuildContext context, int index) {
    final screenWidth = MediaQuery.of(context).size.width;

    TextDirection textDirection = Directionality.of(context);

    double animationDirection = textDirection == TextDirection.ltr ? -1 : 1;

    final transform = Matrix4.translationValues(
      animationDirection * (screenWidth - _animation.value * screenWidth) * ((items.length - index) / 4),
      0.0,
      0.0,
    );

    return Align(
      alignment: textDirection == TextDirection.ltr ? Alignment.centerRight : Alignment.centerLeft,
      child: Transform(
        transform: transform,
        child: Opacity(
          opacity: _animation.value,
          child: BubbleMenu(items[index]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomLeft, children: [
      Container(
        decoration: BoxDecoration(
          color: AppColor.black.withOpacity(_animation.value * 0.8),
        ),
        height: _animation.value * Get.height,
      ),
      Transform.translate(
        offset: Offset(0, -92.0.sp - (Get.context?.mediaQueryPadding.bottom ?? 32.0.sp)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: 12.0.sp,
            ),
            Expanded(
              child: IgnorePointer(
                ignoring: _animation.value == 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List<Widget>.generate(
                    items.length,
                    (index) => buildItem(context, index),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 12.0.sp,
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 260),
              child: AppTouchable(
                height: 60.0.sp,
                width: 60.0.sp,
                backgroundColor: _animation.value == 0 ? backgroundCloseColor : backgroundOpenColor,
                onPressed: onPress,
                child: Icon(
                  _animation.value == 0 ? Icons.add : Icons.close,
                  color: AppColor.white,
                  size: 32.0.sp,
                ),
              ),
            ),
            SizedBox(
              width: 12.0.sp,
            )
          ],
        ),
      ),
    ]);
  }
}

class Bubble {
  const Bubble({
    required String title,
    required Color bubbleColor,
    TextStyle? titleStyle,
    IconData? icon,
    Color? iconColor,
    required this.onPress,
  })  : _icon = icon,
        _iconColor = iconColor,
        _title = title,
        _titleStyle = titleStyle,
        _bubbleColor = bubbleColor;

  final IconData? _icon;
  final Color? _iconColor;
  final String _title;
  final TextStyle? _titleStyle;
  final Color _bubbleColor;
  final void Function() onPress;
}

class BubbleMenu extends StatelessWidget {
  const BubbleMenu(this.item, {super.key});

  final Bubble item;

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      padding: EdgeInsets.symmetric(horizontal: 20.0.sp, vertical: 14.0.sp),
      height: 60.0.sp,
      backgroundColor: item._bubbleColor,
      margin: EdgeInsets.only(top: 12.0.sp),
      width: double.infinity,
      onPressed: item.onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          if (item._icon != null) ...[
            Icon(
              item._icon,
              color: item._iconColor,
            ),
            const SizedBox(
              width: 10.0,
            )
          ],
          Text(
            item._title,
            style: item._titleStyle ??
                textStyle20500().copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
