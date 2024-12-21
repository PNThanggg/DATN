import 'package:flutter/widgets.dart';

class DisableGlowBehavior extends ScrollBehavior {
  const DisableGlowBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
