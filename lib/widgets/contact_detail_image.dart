import 'dart:math';
import 'package:flutter/material.dart';

/// Defines a point to which  a straight line should drawn in a vertical direction only.
class VerticalPoint<T extends num> extends Point<T> {
  VerticalPoint(num y, [num x]) : super(x, y);
}

/// Defines a point to which a straight line should be drawn in a horizontal direction only.
class HorizontalPoint<T extends num> extends Point<T> {
  HorizontalPoint(num x, [num y]) : super(x, y);
}

/// Defines a point where a path starts and the painter should therefore move to the
/// starting point.
class MovePoint<T extends num> extends Point<T> {
  MovePoint(T x, T y) : super(x, y);
}

/// Defines a series of points which together create a curved line.
class CurvePoints<T extends num> extends Point<T> {
  final num x2;
  final num y2;
  final num x3;
  final num y3;
  CurvePoints(num x1, num y1, this.x2, this.y2, this.x3, this.y3)
      : super(x1, y1);
}

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

  /// Draws a path onto the [canvas] at the [start] based on the type of [points] supplied 
  /// and the [paint] that should be used.
  drawPathFromPoints(Canvas canvas, Paint paint, List<Point> points, Point start) {
    Path path = Path();
    points.forEach((p) {
      if (p is MovePoint) {
        p = MovePoint(start.x, start.y);
        path.moveTo(p.x, p.y);
      } else if (p is VerticalPoint) {
        p = VerticalPoint(p.y * scale, (p.x * scale));
        path.relativeLineTo(p.x, p.y);
      } else if (p is HorizontalPoint) {
        p = HorizontalPoint((p.x * scale), (p.y * scale));
        path.relativeLineTo(p.x, p.y);
      } else {
        CurvePoints cp = p as CurvePoints;
        cp = CurvePoints((cp.x * scale), (cp.y * scale), (cp.x2 * scale),
            (cp.y2 * scale), (cp.x3 * scale), (cp.y3 * scale));
        path.relativeCubicTo(cp.x, cp.y, cp.x2, cp.y2, cp.x3, cp.y3);
      }
    });
    canvas.drawPath(path, paint);
  }

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

    drawPathFromPoints(canvas, path1Paint, path1, start);
    canvas.drawCircle(Offset(start.x, start.y), 4.0 * scale, path2Paint);
    Point start2 = Point(start.x, start.y + (6 * scale));
    drawPathFromPoints(canvas, path3Paint, path3, start2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
