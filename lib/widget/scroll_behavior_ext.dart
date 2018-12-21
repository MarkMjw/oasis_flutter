import 'package:flutter/material.dart';

class ScrollBehaviorExt extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
