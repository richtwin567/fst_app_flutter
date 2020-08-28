import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/linear_ring.dart';

class GeoJSONPolygon extends GeoJSONGeometryObject {
  List<GeoJSONLinearRing> _coordinates;

  List<GeoJSONLinearRing> get coordinates => _coordinates;

  GeoJSONPolygon({@required coordsJSON})
      : assert(coordsJSON != null),
        super(GeoJSONGeometryType.Polygon) {
    _coordinates = [];
    var linearRingCoords = [];
    for (var i = 0; i < coordsJSON.length; i++) {
      if (coordsJSON[i]['marker'] == 'END') {
        linearRingCoords.add(coordsJSON[i]);
        _coordinates.add(GeoJSONLinearRing(coordsJSON: linearRingCoords));
        linearRingCoords = [];
      } else {
        linearRingCoords.add(coordsJSON[i]);
      }
    }
  }

  @override
  toGeoJSONFile() {
    return {
      '\"type\"': '\"${type.toShortString()}\"',
      '\"coordinates\"': coordinates.map((e) => e.toGeoJSONFile()).toList()
    };
  }

  @override
  toGeoJSON() {
    return {
      'type': type.toShortString(),
      'coordinates': coordinates.map((e) => e.toGeoJSON()).toList()
    };
  }

  @override
  extractLatLng() {
    var list = coordinates.expand((e) => e.extractLatLng()).toList();
    print(list.runtimeType);
    print(list);
    return list;
  }
  /*
  For Polygons with more than one of these rings, the first MUST be
      the exterior ring, and any others MUST be interior rings.  The
      exterior ring bounds the surface, and the interior rings (if
      present) bound holes within the surface.*/
}
