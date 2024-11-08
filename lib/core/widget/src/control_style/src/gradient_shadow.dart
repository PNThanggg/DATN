import 'dart:math' as math;
import 'dart:ui' as ui show lerpDouble;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A gradient shadow of a border of a box.
class GradientShadow extends BoxShadow {
  /// Creates the box gradient shadow.
  ///
  /// By default, there is no shadow.
  const GradientShadow({
    required this.gradient,
    super.color = Colors.transparent,
    super.offset,
    super.blurRadius,
    super.spreadRadius,
    super.blurStyle,
  });

  /// A gradient to use when drawing the shadow.
  final Gradient gradient;

  /// Creates the [Paint] object that corresponds to this shadow description.
  Paint toPaintRect(Rect rect, {TextDirection? textDirection}) {
    final result = Paint()
      ..color = const Color(0xFF000000)
      ..maskFilter = MaskFilter.blur(blurStyle, blurSigma)
      ..shader = gradient.createShader(rect, textDirection: textDirection);

    assert(
      () {
        if (debugDisableShadows) result.maskFilter = null;
        return true;
      }(),
      'For debugging purposes',
    );
    return result;
  }

  /// Linearly interpolate between two gradient shadows.
  ///
  /// The arguments must not be null.
  static BoxShadow? lerp(BoxShadow? a, BoxShadow? b, double t) {
    if (identical(a, b)) {
      return a;
    }
    if (a == null) return b!.scale(t);
    if (b == null) return a.scale(1.0 - t);

    if (a is GradientShadow && b is GradientShadow) {
      return GradientShadow(
        color: Color.lerp(a.color, b.color, t)!,
        gradient: Gradient.lerp(a.gradient, b.gradient, t)!,
        offset: Offset.lerp(a.offset, b.offset, t)!,
        blurRadius: ui.lerpDouble(a.blurRadius, b.blurRadius, t)!,
        spreadRadius: ui.lerpDouble(a.spreadRadius, b.spreadRadius, t)!,
        blurStyle: a.blurStyle == BlurStyle.normal ? b.blurStyle : a.blurStyle,
      );
    }
    return BoxShadow.lerp(a, b, t);
  }

  /// Linearly interpolate between two lists of box shadows.
  ///
  /// If the lists differ in length, excess items are lerped with null.
  static List<BoxShadow>? lerpList(
    List<BoxShadow>? a,
    List<BoxShadow>? b,
    double t,
  ) {
    if (identical(a, b)) {
      return a;
    }
    a ??= <BoxShadow>[]; // ignore: parameter_assignments
    b ??= <BoxShadow>[]; // ignore: parameter_assignments
    final int commonLength = math.min(a.length, b.length);
    return <BoxShadow>[
      for (int i = 0; i < commonLength; i += 1)
        GradientShadow.lerp(a[i], b[i], t)!,
      for (int i = commonLength; i < a.length; i += 1) a[i].scale(1.0 - t),
      for (int i = commonLength; i < b.length; i += 1) b[i].scale(t),
    ];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is GradientShadow &&
        other.color == color &&
        other.gradient == gradient &&
        other.offset == offset &&
        other.blurRadius == blurRadius &&
        other.spreadRadius == spreadRadius &&
        other.blurStyle == blurStyle;
  }

  @override
  int get hashCode =>
      Object.hash(color, offset, blurRadius, spreadRadius, blurStyle, gradient);

  @override
  String toString() =>
      'GradientShadow($color, $offset, ${debugFormatDouble(blurRadius)}, '
      '${debugFormatDouble(spreadRadius)}, $gradient), $blurStyle';
}
