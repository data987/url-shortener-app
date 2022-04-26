import 'package:flutter/material.dart';

extension WidgetMethods on Widget {
  Widget material() => Material(type: MaterialType.transparency, child: this);
  Widget container(
      {double? width,
      double? height,
      Color? color = Colors.white,
      EdgeInsetsGeometry? padding}) {
    return Container(
      child: this,
      padding: padding,
      color: color,
      width: width,
      height: height,
    );
  }

  Widget expanded() => Expanded(child: this);
  Widget flexible() => Flexible(child: this);
  Widget center() => Center(child: this);

  Widget paddingOnly(
      {double top = 0.0,
      double right = 0.0,
      double bottom = 0.0,
      double left = 0.0}) {
    return Padding(
        padding:
            EdgeInsets.only(top: top, right: right, bottom: bottom, left: left),
        child: this);
  }
}
