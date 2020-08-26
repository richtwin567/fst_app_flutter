import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/position.dart';

class LineString extends GeometryObject {
  List<Position> _coordinates;

  List<Position> get coordinates => _coordinates;

  LineString({@required coordsJSON})
      : assert(coordsJSON != null),
        assert(coordsJSON.length >= 2),
        super(GeometryType.LineString) {
    _coordinates = List.generate(
        coordsJSON.length,
        (i) => Position(
            newLongitude: coordsJSON[i]['longitude'],
            newLatitude: coordsJSON[i]['latitude']));
  }

  @override
  toGeoJSON() {
    return {
      '\"type\"': '\"${type.toShortString()}\"',
      '\"coordinates\"': coordinates.map((e) => e.toGeoJSON()).toList()
    };
  }
}
