import 'package:flutter/material.dart';

class DownArrowTooltip extends ShapeBorder {
  final double arrowWidth;
  final double arrowHeight;
  final double radius;
  final Color color;

  DownArrowTooltip({this.color, 
      this.arrowWidth = 20.0, this.arrowHeight = 10.0, this.radius = 0.0})
      : super();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: arrowHeight);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => null;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path path = Path();
    rect = Rect.fromPoints(
        rect.topLeft, rect.bottomRight - Offset(0, arrowHeight));
    return path
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)))
      ..moveTo(rect.bottomCenter.dx - (arrowWidth / 2), rect.bottomCenter.dy)
      ..lineTo(rect.bottomCenter.dx, rect.bottomCenter.dy + arrowHeight)
      ..lineTo(rect.bottomCenter.dx + (arrowWidth / 2), rect.bottomCenter.dy);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    canvas.drawPath(getOuterPath(rect), Paint()..style =PaintingStyle.stroke..color = color ?? Color.fromRGBO(0, 0, 0, 0));
  }

  @override
  ShapeBorder scale(double t) => this;
}
