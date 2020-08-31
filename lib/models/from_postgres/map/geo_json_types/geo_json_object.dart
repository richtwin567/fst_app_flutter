import 'package:fst_app_flutter/models/from_postgres/map/geo_json_types/geo_json_type.dart';

abstract class GeoJsonObject {
  GeoJsonType type;
  List<int> bbox;

  GeoJsonObject(this.type);

  toGeoJsonFile();

  Map<String, Object> toGeoJson();
}
