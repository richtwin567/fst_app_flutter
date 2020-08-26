import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';

abstract class GeometryObject {
  final GeometryType type;

  GeometryObject(this.type);

  toGeoJSON();
}
