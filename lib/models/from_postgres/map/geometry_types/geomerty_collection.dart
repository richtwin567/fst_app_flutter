import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';

class GeometryCollection extends GeometryObject {
  List<GeometryObject> geometries;
  GeometryCollection({@required geometries})
      : super(GeometryType.GeometryCollection);

  @override
  toGeoJSON() {
    // TODO: implement toGeoJSON
    throw UnimplementedError();
  }
}
