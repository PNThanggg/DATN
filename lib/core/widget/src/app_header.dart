import 'package:flutter/material.dart';

import 'app_touchable.dart';

class AppHeader extends StatelessWidget {
  final String? title;
  final String? hintContent;
  final String? hintTitle;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final Widget? middleWidget;
  final Widget? extendWidget;
  final CrossAxisAlignment? crossAxisAlignmentMainRow;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final EdgeInsets? headerPadding;
  final Color? colorTitle;

  const AppHeader({
    super.key,
    this.title,
    this.leftWidget,
    this.rightWidget,
    this.middleWidget,
    this.extendWidget,
    this.crossAxisAlignmentMainRow,
    this.hintContent,
    this.hintTitle,
    this.titleStyle,
    this.backgroundColor,
    this.headerPadding,
    this.colorTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: headerPadding ??
          EdgeInsets.fromLTRB(
            0.0,
            MediaQuery.of(context).padding.top + 12.0,
            0.0,
            8,
          ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(24.0),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            child: Row(
              crossAxisAlignment: crossAxisAlignmentMainRow ?? CrossAxisAlignment.center,
              children: [
                leftWidget ??
                    AppTouchable(
                      width: 40.0,
                      height: 40.0,
                      padding: const EdgeInsets.all(2.0),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        size: 24,
                      ),
                    ),
                Expanded(
                  child: middleWidget ??
                      Text(
                        title ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                        ).merge(
                          titleStyle,
                        ),
                      ),
                ),
                rightWidget ??
                    const SizedBox(
                      width: 40.0,
                    ),
              ],
            ),
          ),
          extendWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
