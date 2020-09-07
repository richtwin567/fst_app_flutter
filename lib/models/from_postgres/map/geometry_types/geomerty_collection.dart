import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';

// TODO: document GeoJsonGeometryCollection @richtwin567
class GeoJsonGeometryCollection extends GeoJsonGeometryObject {
  List<GeoJsonGeometryObject> geometries;
  GeoJsonGeometryCollection({@required geometries})
      : super(GeoJsonGeometryType.geometryCollection);

  @override
  toGeoJsonFile() {
    throw UnimplementedError();
  }

  @override
  toGeoJson() {
    throw UnimplementedError();
  }

  @override
  extractLatLng() {
    throw UnimplementedError();
  }
}
