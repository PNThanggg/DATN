import 'package:flutter/material.dart';

import 'animated_text.dart';

class TyperAnimatedText extends AnimatedText {
  final Duration speed;
  final Curve curve;

  TyperAnimatedText(
    String text, {
    super.textAlign,
    super.textStyle,
    this.speed = const Duration(milliseconds: 40),
    this.curve = Curves.linear,
  }) : super(
          text: text,
          duration: speed * text.characters.length,
        );

  late Animation<double> _typingText;

  @override
  Duration get remaining => speed * (textCharacters.length - _typingText.value);

  @override
  void initAnimation(AnimationController controller) {
    _typingText = CurveTween(
      curve: curve,
    ).animate(controller);
  }

  /// Widget showing partial text, up to [count] characters
  @override
  Widget animatedBuilder(BuildContext context, Widget? child) {
    /// Output of CurveTween is in the range [0, 1] for majority of the curves.
    /// It is converted to [0, textCharacters.length].
    final count = (_typingText.value.clamp(0, 1) * textCharacters.length).round();

    assert(count <= textCharacters.length);
    return textWidget(textCharacters.take(count).toString());
  }
}

@Deprecated('Use AnimatedTextWidget with TyperAnimatedText instead.')
class TyperAnimatedTextKit extends AnimatedTextWidget {
  TyperAnimatedTextKit({
    super.key,
    required List<String> text,
    TextAlign textAlign = TextAlign.start,
    TextStyle? textStyle,
    Duration speed = const Duration(milliseconds: 40),
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
          animatedTexts: _animatedTexts(text, textAlign, textStyle, speed, curve),
        );

  static List<AnimatedText> _animatedTexts(
    List<String> text,
    TextAlign textAlign,
    TextStyle? textStyle,
    Duration speed,
    Curve curve,
  ) =>
      text
          .map(
            (_) => TyperAnimatedText(
              _,
              textAlign: textAlign,
              textStyle: textStyle,
              speed: speed,
              curve: curve,
            ),
          )
          .toList();
}
