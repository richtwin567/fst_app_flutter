import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';

class GeoJSONGeometryCollection extends GeoJSONGeometryObject {
  List<GeoJSONGeometryObject> geometries;
  GeoJSONGeometryCollection({@required geometries})
      : super(GeoJSONGeometryType.GeometryCollection);

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
}
