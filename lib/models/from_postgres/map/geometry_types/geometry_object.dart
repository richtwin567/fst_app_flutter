import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class GeoJsonGeometryObject {
  final GeoJsonGeometryType type;

  GeoJsonGeometryObject(this.type);

  toGeoJsonFile();

  toGeoJson();

  List<LatLng> extractLatLng();
}
