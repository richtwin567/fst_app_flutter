import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/position.dart';

class Point extends GeometryObject {
  Position _coordinates;

  Position get coordinates => _coordinates;

  Point({@required coordsJSON})
      : assert(coordsJSON != null),
        super(GeometryType.Point) {
    print(coordsJSON[0]['longitude'] is double);
    _coordinates = Position(
        newLongitude: coordsJSON[0]['longitude'],
        newLatitude: coordsJSON[0]['latitude']);
  }

  @override
  Map toGeoJSON() {
    return {
      '\"type\"': '\"${type.toShortString()}\"',
      '\"coordinates\"': coordinates.toGeoJSON()
    };
  }
}
