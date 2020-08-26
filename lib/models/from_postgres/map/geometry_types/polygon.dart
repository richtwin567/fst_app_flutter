import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/linear_ring.dart';

class Polygon extends GeometryObject {
  List<LinearRing> coordinates;
  Polygon({@required coordsJSON})
      : assert(coordsJSON != null),
        super(GeometryType.Polygon) {
    coordinates = [];
    var linearRingCoords = [];
    for (var i = 0; i < coordsJSON.length; i++) {
      if (coordsJSON[i]['marker'] == 'END') {
        linearRingCoords.add(coordsJSON[i]);
        coordinates.add(LinearRing(coordsJSON: linearRingCoords));
        linearRingCoords = [];
      } else {
        linearRingCoords.add(coordsJSON[i]);
      }
    }
  }

  @override
  toGeoJSON() {
    return {
      '\"type\"': '\"${type.toShortString()}\"',
      '\"coordinates\"': coordinates.map((e) => e.toGeoJSON()).toList()
    };
  }
  /*
  For Polygons with more than one of these rings, the first MUST be
      the exterior ring, and any others MUST be interior rings.  The
      exterior ring bounds the surface, and the interior rings (if
      present) bound holes within the surface.*/
}
