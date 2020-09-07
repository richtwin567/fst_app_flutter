import 'dart:math';

import 'package:flutter/material.dart';

// TODO: document @richtwin567

class LinePoint<T extends num> extends Point<T> {
  LinePoint(T x, T y) : super(x, y);
}

/// Defines a point to which  a straight line should drawn in a vertical direction only.
///
/// Denoted by V or v in svg followed by a number
class VerticalPoint<T extends num> extends Point<T> {
  VerticalPoint(num y, num x) : super(x, y);
}

/// Defines a point to which a straight line should be drawn in a horizontal direction only.
///
/// Denoted by H or h in svg followed by a number
class HorizontalPoint<T extends num> extends Point<T> {
  HorizontalPoint(num x, num y) : super(x, y);
}

/// Defines a point where a path starts and the painter should therefore move to the
/// starting point.
///
/// Denoted by M or m in svg followed by 2 numbers
class MovePoint<T extends num> extends Point<T> {
  MovePoint(T x, T y) : super(x, y);
}

/// Defines a series of points which together create a curved line.
///
/// Denoted by C, c, S, s followed by 3 pairs of points
class CurvePoints<T extends num> extends Point<T> {
  final num x2;
  final num y2;
  final num x3;
  final num y3;
  CurvePoints(num x1, num y1, this.x2, this.y2, this.x3, this.y3)
      : super(x1, y1);
}

// TODO: document @richtwin567
/// Draws a path onto the [canvas] at the [start] based on the type of [points] supplied
/// and the [paint] that should be used.
drawPathFromPoints(Canvas canvas, Paint paint, List<Point> points, Point start,
    double scale, bool applyScaleToStart) {
  Path path = Path();
  points.forEach((p) {
    if (p is MovePoint) {
      p = applyScaleToStart
          ? MovePoint(start.x * scale, start.y * scale)
          : MovePoint(start.x, start.y);
      path.moveTo(p.x, p.y);
    } else if (p is VerticalPoint) {
      p = VerticalPoint(p.y * scale, (p.x * scale));
      path.relativeLineTo(p.x, p.y);
    } else if (p is HorizontalPoint) {
      p = HorizontalPoint((p.x * scale), (p.y * scale));
      path.relativeLineTo(p.x, p.y);
    } else if (p is LinePoint) {
      p = LinePoint(p.x * scale, p.y * scale);
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
