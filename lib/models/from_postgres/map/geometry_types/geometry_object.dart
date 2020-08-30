import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class GeoJSONGeometryObject {
  final GeoJSONGeometryType type;

  GeoJSONGeometryObject(this.type);

  toGeoJSONFile();

  toGeoJSON();

  List<LatLng> extractLatLng();
}
