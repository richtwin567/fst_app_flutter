import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/svg_model.dart';

/// The [CustomPainter] implementation of the svg version of [Icons.person].
class ContactDetailSvg extends CustomPainter {
  /// The background box
  List<Point<double>> path1 = [
    MovePoint(0.0, 0.0),
    HorizontalPoint(24.0, 0.0),
    VerticalPoint(24.0, 0.0),
    HorizontalPoint(-24.0, 0.0)
  ];

  /// The head
  List<Point<double>> path2 = [
    MovePoint(12.0, 12.0),
    CurvePoints(0.0, 0.0, 3.8, 0.0, 4.0, -4.0),
    CurvePoints(0.0, 0.0, 0.0, -3.8, -4.0, -4.0),
    CurvePoints(0.0, 0.0, -3.8, 0.0, -4.0, 4.0),
    CurvePoints(0.0, 0.0, 0.0, 3.8, 4.0, 4.0),
  ];

  /// The bust
  List<Point<double>> path3 = [
    MovePoint(12.0, 14.0),
    CurvePoints(-2.67, 0.0, -8.0, 1.34, -8.0, 4.0),
    VerticalPoint(2.0, 0.0),
    HorizontalPoint(16.0, 0.0),
    VerticalPoint(-2.0, 0.0),
    CurvePoints(0.0, -2.66, -5.33, -4.0, -8.0, -4.0)
  ];

  /// How big the the icon should be drawn.
  final double scale;

  /// the color of the icon.
  final Color color;

  /// The first starting point.
  final Point start;

  /// Accepts the [color] of the icon, how much to [scale] the icon by and where
  /// the drawing should [start].
  ContactDetailSvg(
      {@required this.color, this.scale = 1.0, @required this.start})
      : super();

  /// Uses [drawPathFromPoints] to paint the icon onto the [canvas].
  @override
  void paint(Canvas canvas, Size size) {
    Paint path1Paint = Paint();
    path1Paint..color = Color.fromRGBO(0, 0, 0, 0);

    Paint path2Paint = Paint();
    path2Paint
      ..color = color
      ..style = PaintingStyle.fill;

    Paint path3Paint = Paint();
    path3Paint
      ..color = color
      ..style = PaintingStyle.fill;

    drawPathFromPoints(canvas, path1Paint, path1, start, scale, false);
    canvas.drawCircle(Offset(start.x, start.y), 4.0 * scale, path2Paint);
    Point start2 = Point(start.x, start.y + (6 * scale));
    drawPathFromPoints(canvas, path3Paint, path3, start2, scale, false);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
