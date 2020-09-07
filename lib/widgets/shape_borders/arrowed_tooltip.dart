import 'package:flutter/material.dart';

// TODO: document @richtwin567
abstract class ArrowedTooltip extends ShapeBorder {
  final double arrowWidth;
  final double arrowLength;
  final double radius;
  final Color color;

  ArrowedTooltip(this.arrowWidth, this.arrowLength, this.radius, this.color);
}

class RightArrowTooltip extends ArrowedTooltip {
  RightArrowTooltip(
      {@required double arrowWidth,
      @required double arrowLength,
      double radius = 0.0,
      Color color})
      : assert(arrowWidth != null),
        assert(arrowLength != null),
        super(arrowWidth, arrowLength, radius, color);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(right: arrowLength);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => null;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path path = Path();
    rect = Rect.fromLTRB(
        rect.left, rect.top, rect.right - arrowLength, rect.bottom);
    return path
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)))
      ..moveTo(rect.centerRight.dx, rect.centerRight.dy + (arrowWidth/2))
      ..lineTo(rect.centerRight.dx + arrowLength, rect.centerRight.dy)
      ..lineTo(rect.centerRight.dx, rect.centerRight.dy - (arrowWidth/2));
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    canvas.drawPath(
        getOuterPath(rect),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = color ?? Colors.transparent);
  }

  @override
  ShapeBorder scale(double t) => this;
}

class DownArrowTooltip extends ArrowedTooltip {
  DownArrowTooltip(
      {@required double arrowWidth,
      @required double arrowLength,
      double radius = 0.0,
      Color color})
      : assert(arrowWidth != null),
        assert(arrowLength != null),
        super(arrowWidth, arrowLength, radius, color);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: arrowLength);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => null;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path path = Path();
    rect = Rect.fromPoints(
        rect.topLeft, rect.bottomRight - Offset(0, arrowLength));
    return path
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)))
      ..moveTo(rect.bottomCenter.dx - (arrowWidth / 2), rect.bottomCenter.dy)
      ..lineTo(rect.bottomCenter.dx, rect.bottomCenter.dy + arrowLength)
      ..lineTo(rect.bottomCenter.dx + (arrowWidth / 2), rect.bottomCenter.dy);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    canvas.drawPath(
        getOuterPath(rect),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = color ?? Colors.transparent);
  }

  @override
  ShapeBorder scale(double t) => this;
}
