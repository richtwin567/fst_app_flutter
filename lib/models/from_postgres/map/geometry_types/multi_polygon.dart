import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/polygon.dart';

class MultiPolygon extends GeometryObject {
  List<Polygon> coordinates;
  MultiPolygon({@required coordsJSON}) : super(GeometryType.MultiPolygon) {
    coordinates = [];
    var polygonCoords = [];
    for (var i = 0; i < coordsJSON.length; i++) {
      if (coordsJSON[i]['marker'] == 'END') {
        polygonCoords.add(coordsJSON[i]);
        coordinates.add(Polygon(coordsJSON: polygonCoords));
        polygonCoords = [];
      } else {
        polygonCoords.add(coordsJSON[i]);
      }
    }
  }

  @override
  toGeoJSON() {
    // TODO: implement toGeoJSON
    throw UnimplementedError();
  }
  /*
  For Polygons with more than one of these rings, the first MUST be
      the exterior ring, and any others MUST be interior rings.  The
      exterior ring bounds the surface, and the interior rings (if
      present) bound holes within the surface.*/
}
