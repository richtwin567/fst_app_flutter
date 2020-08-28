import 'package:fst_app_flutter/models/from_postgres/map/geo_json_types/geo_json_type.dart';

abstract class GeoJSONObject {
  GeoJSONType type;
  List<int> bbox;

  GeoJSONObject(this.type);

  toGeoJSONFile();

  Map<String, Object> toGeoJSON();
}
