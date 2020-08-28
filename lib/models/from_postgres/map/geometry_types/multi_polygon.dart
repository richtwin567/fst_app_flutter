import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/polygon.dart';

class GeoJSONMultiPolygon extends GeoJSONGeometryObject {
  List<GeoJSONPolygon> coordinates;
  GeoJSONMultiPolygon({@required coordsJSON}) : super(GeoJSONGeometryType.MultiPolygon) {
    coordinates = [];
    var polygonCoords = [];
    for (var i = 0; i < coordsJSON.length; i++) {
      if (coordsJSON[i]['marker'] == 'END') {
        polygonCoords.add(coordsJSON[i]);
        coordinates.add(GeoJSONPolygon(coordsJSON: polygonCoords));
        polygonCoords = [];
      } else {
        polygonCoords.add(coordsJSON[i]);
      }
    }
  }

  @override
  toGeoJSONFile() {
    throw UnimplementedError();
  }

  @override
  toGeoJSON() {
    throw UnimplementedError();
  }

  @override
  extractLatLng() {
    throw UnimplementedError();
  }
  /*
  For Polygons with more than one of these rings, the first MUST be
      the exterior ring, and any others MUST be interior rings.  The
      exterior ring bounds the surface, and the interior rings (if
      present) bound holes within the surface.*/
}
