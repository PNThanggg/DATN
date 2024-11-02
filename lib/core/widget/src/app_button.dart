import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final Function? onPressed;
  final String? text;
  final double? width;
  final Color? color;
  final Color? textColor;
  final Color? disabledColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final TextStyle? textStyle;
  final ShapeBorder? shapeBorder;
  final Widget? child;
  final double? elevation;
  final double? height;
  final double radius;
  final BoxDecoration? decoration;
  final bool enabled;
  final bool enableScaleAnimation;
  final Color? disabledTextColor;
  final double? hoverElevation;
  final double? focusElevation;
  final double? highlightElevation;

  const AppButton({
    this.onPressed,
    this.text,
    this.width,
    this.color,
    this.textColor,
    this.padding,
    this.margin,
    this.textStyle,
    this.shapeBorder,
    this.child,
    this.elevation,
    this.enabled = true,
    this.radius = 8,
    this.decoration,
    this.height,
    this.disabledColor,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.enableScaleAnimation = true,
    this.disabledTextColor,
    this.hoverElevation,
    this.focusElevation,
    this.highlightElevation,
    super.key,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  AnimationController? _controller;

  double defaultAppButtonElevation = 0.0;
  double defaultAppButtonFocusElevation = 4.0;
  double defaultAppButtonHighlightElevation = 4.0;
  double defaultAppButtonHoverElevation = 4.0;
  bool enableAppButtonScaleAnimationGlobal = true;

  @override
  void initState() {
    if (widget.enableScaleAnimation) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 50,
        ),
        lowerBound: 0.0,
        upperBound: 0.1,
      )..addListener(() {
          setState(() {});
        });
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _buildButton() {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin ?? EdgeInsets.zero,
      padding: widget.padding ?? EdgeInsets.zero,
      decoration: widget.decoration,
      child: Material(
        color: widget.color ?? Colors.transparent,
        shape: widget.shapeBorder ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius),
            ),
        elevation: widget.elevation ?? defaultAppButtonElevation,
        child: InkWell(
          onTap: widget.enabled ? widget.onPressed as void Function()? : null,
          splashColor: widget.splashColor,
          borderRadius: BorderRadius.circular(widget.radius),
          child: Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child: widget.child ??
                Text(
                  widget.text ?? '',
                  style: widget.textStyle ?? Theme.of(context).textTheme.displayMedium,
                ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_controller != null && widget.enabled) {
      _scale = 1 - _controller!.value * 0.25;
    }

    if (widget.enableScaleAnimation) {
      return Listener(
        onPointerDown: (details) {
          _controller?.forward();
        },
        onPointerUp: (details) {
          _controller?.reverse();
        },
        child: Transform.scale(
          scale: _scale,
          child: _buildButton(),
        ),
      );
    } else {
      return _buildButton();
    }
  }

  bool get isElevationEnabled {
    return widget.elevation != 0 &&
        defaultAppButtonElevation != 0 &&
        widget.focusElevation != 0 &&
        defaultAppButtonFocusElevation != 0 &&
        widget.highlightElevation != 0 &&
        defaultAppButtonHighlightElevation != 0 &&
        widget.hoverElevation != 0 &&
        defaultAppButtonHoverElevation != 0;
  }
}
