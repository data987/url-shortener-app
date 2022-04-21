import 'package:flutter/material.dart';

extension WidgetMethods on Widget {
  Widget alignment(AlignmentGeometry alignment) {
    return Align(alignment: alignment, child: this);
  }

  Widget material() => Material(type: MaterialType.transparency, child: this);
  Widget container() => Container(child: this);
  Widget showScrollbar() => Scrollbar(child: this);
  Widget singleChildScrollView() => SingleChildScrollView(child: this);
  Widget expanded() => Expanded(child: this);
  Widget flexible() => Flexible(child: this);
  Widget center() => Center(child: this);
  Widget paddingAll(double padding) {
    return Padding(padding: EdgeInsets.all(padding), child: this);
  }

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

  Widget paddingSymmetric({double vertical = 0.0, double horizontal = 0.0}) {
    return Padding(
        padding:
            EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
        child: this);
  }
}
