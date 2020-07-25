import 'dart:async' show Future;
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

/* Future<String> extractAssetContent(String assetPath) async {
  var s = await rootBundle.loadString(assetPath);
  print(s); //for debug
  parseSvgAssetContent(s);
  return s;
}

parseSvgAssetContent(String svgContent) {
  var lines = svgContent.split(new RegExp('[<,>,"]'));

  lines.removeWhere((element) =>
      element.isEmpty || element == '/' || element.contains('svg'));

  List<String> parts = [];
  lines.forEach((element) {
    parts.add(element.trim());
  });

  int pathsStart;
  Map<String, dynamic> properties = {};
  for (var i = 0; i < parts.length - 2; i += 2) {
    if (!parts[i].contains('path')) {
      properties
          .addAll({parts[i].substring(0, parts[i].length - 1): parts[i + 1]});
    } else {
      properties.addAll({
        'path': [
          {'d': parts[i + 1], 'commands': []}
        ]
      });
      pathsStart = i + 2;
      break;
    }
  }
  int pathNum = 0;
  for (var x = pathsStart; x < parts.length; x += 2) {
    if (!parts[x].contains('path')) {
      properties['path'][pathNum]
          .addAll({parts[x].substring(0, parts[x].length - 1): parts[x + 1]});
    } else {
      pathNum++;
      properties['path'].add({'d': parts[x + 1], 'commands': []});
    }
  }
  for (var i = 0; i < properties['path'].length; i++) {
    int startCommand;
    int endCommand;
    String commandsString = properties['path'][i]['d'];
    int length = commandsString.length;
    //print('full string - ' + commandsString + ' - $length');
    for (var x = 0; x < commandsString.length; x++) {
      if (commandsString[x].contains(new RegExp('[a-zA-Z]'))) {
        startCommand = x;
        //print('start - ' + commandsString[startCommand] + ' - $startCommand');

        if (startCommand + 1 < commandsString.length) {
          for (var p = startCommand + 1; p < commandsString.length; p++) {
            if (commandsString[p].contains(new RegExp('[a-zA-Z]'))) {
              endCommand = p;
              //print('end - ' + commandsString[endCommand] + ' - $endCommand');
              //print(commandsString.substring(startCommand, endCommand));
              properties['path'][i]['commands']
                  .add(commandsString.substring(startCommand, endCommand));
              //print(properties['path'][i]['commands']);
              break;
            }
          }
        } else {
          properties['path'][i]['commands']
              .add(commandsString[commandsString.length - 1]);
        }
      }
    }
  }
  //print(properties);

  //return properties;
}
 */
class VerticalPoint<T extends num> extends Point<T> {
  VerticalPoint(num y, [num x]) : super(x, y);
}

class HorizontalPoint<T extends num> extends Point<T> {
  HorizontalPoint(num x, [num y]) : super(x, y);
}

class MovePoint<T extends num> extends Point<T> {
  MovePoint(T x, T y) : super(x, y);
}

class CurvePoints<T extends num> extends Point<T> {
  final num x2;
  final num y2;
  final num x3;
  final num y3;
  CurvePoints(num x1, num y1, this.x2, this.y2, this.x3, this.y3)
      : super(x1, y1);
}


class ContactDetailSvg extends CustomPainter {
  List<Point<double>> path1 = [
    MovePoint(0.0, 0.0),
    HorizontalPoint(24.0, 0.0),
    VerticalPoint(24.0, 0.0),
    HorizontalPoint(-24.0, 0.0)
  ];

  List<Point<double>> path2 = [
    MovePoint(12.0, 12.0),
    CurvePoints(0.0, 0.0, 3.8, 0.0, 4.0, -4.0),
    CurvePoints(0.0, 0.0, 0.0, -3.8, -4.0, -4.0),
    CurvePoints(0.0, 0.0, -3.8, 0.0, -4.0, 4.0),
    CurvePoints(0.0, 0.0, 0.0, 3.8, 4.0, 4.0),
  ];

  List<Point<double>> path3 = [
    MovePoint(12.0, 14.0),
    CurvePoints(-2.67, 0.0, -8.0, 1.34, -8.0, 4.0),
    VerticalPoint(2.0, 0.0),
    HorizontalPoint(16.0, 0.0),
    VerticalPoint(-2.0, 0.0),
    CurvePoints(0.0, -2.66, -5.33, -4.0, -8.0, -4.0)
  ];

  double scale;
  double offsetX;
  double offsetY;
  Color color;

  ContactDetailSvg(
      {@required this.color,
      this.scale = 1.0,
      this.offsetX = 0.0,
      this.offsetY = 0.0})
      : super();

  drawPathFromPoints(Canvas canvas, Paint paint, List<Point> points) {
    Path path = Path();
    points.forEach((p) {
      if (p is MovePoint) {
        p = MovePoint(offsetX + (p.x * scale), offsetY + (p.y * scale));
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

    drawPathFromPoints(canvas, path1Paint, path1);
    canvas.drawCircle(Offset((12.0*scale)+offsetX, (8.0*scale)+offsetY), 4.0*scale, path2Paint);
    drawPathFromPoints(canvas, path3Paint, path3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
