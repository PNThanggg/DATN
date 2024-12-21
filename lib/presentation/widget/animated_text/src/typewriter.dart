import 'package:flutter/material.dart';

import 'animated_text.dart';

class TypewriterAnimatedText extends AnimatedText {
  static const extraLengthForBlinks = 8;

  final Duration speed;

  final Curve curve;

  final String cursor;

  TypewriterAnimatedText(
    String text, {
    super.textAlign,
    super.textStyle,
    this.speed = const Duration(milliseconds: 30),
    this.curve = Curves.linear,
    this.cursor = '_',
  }) : super(
          text: text,
          duration: speed * (text.characters.length + extraLengthForBlinks),
        );

  late Animation<double> _typewriterText;

  @override
  Duration get remaining => speed * (textCharacters.length + extraLengthForBlinks - _typewriterText.value);

  @override
  void initAnimation(AnimationController controller) {
    _typewriterText = CurveTween(
      curve: curve,
    ).animate(controller);
  }

  @override
  Widget completeText(BuildContext context) => RichText(
        text: TextSpan(
          children: [
            TextSpan(text: text),
            TextSpan(
              text: cursor,
              style: const TextStyle(color: Colors.transparent),
            )
          ],
          style: DefaultTextStyle.of(context).style.merge(textStyle),
        ),
        textAlign: textAlign,
      );

  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    final textLen = textCharacters.length;
    final typewriterValue =
        (_typewriterText.value.clamp(0, 1) * (textCharacters.length + extraLengthForBlinks)).round();

    var showCursor = true;
    var visibleString = text;
    if (typewriterValue == 0) {
      visibleString = '';
      showCursor = false;
    } else if (typewriterValue > textLen) {
      showCursor = (typewriterValue - textLen) % 2 == 0;
    } else {
      visibleString = textCharacters.take(typewriterValue).toString();
    }

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: visibleString),
          TextSpan(
            text: cursor,
            style: showCursor ? null : const TextStyle(color: Colors.transparent),
          )
        ],
        style: DefaultTextStyle.of(context).style.merge(textStyle),
      ),
      textAlign: textAlign,
    );
  }
}

@Deprecated('Use AnimatedTextKit with TypewriterAnimatedText instead.')
class TypewriterAnimatedTextKit extends AnimatedTextWidget {
  TypewriterAnimatedTextKit({
    super.key,
    required List<String> text,
    TextAlign textAlign = TextAlign.start,
    required TextStyle textStyle,
    Duration speed = const Duration(milliseconds: 30),
    super.pause,
    super.displayFullTextOnTap,
    super.stopPauseOnTap,
    super.onTap,
    super.onNext,
    super.onNextBeforePause,
    super.onFinished,
    super.isRepeatingAnimation,
    super.repeatForever = true,
    super.totalRepeatCount,
    Curve curve = Curves.linear,
  }) : super(
          animatedTexts: _animatedTexts(
            text,
            textAlign,
            textStyle,
            speed,
            curve,
          ),
        );

  static List<AnimatedText> _animatedTexts(
    List<String> text,
    TextAlign textAlign,
    TextStyle textStyle,
    Duration speed,
    Curve curve,
  ) =>
      text
          .map((_) => TypewriterAnimatedText(
                _,
                textAlign: textAlign,
                textStyle: textStyle,
                speed: speed,
                curve: curve,
              ))
          .toList();
}
