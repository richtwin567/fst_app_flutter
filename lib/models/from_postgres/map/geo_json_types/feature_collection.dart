import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geo_json_types/feature.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geo_json_types/geo_json_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geo_json_types/geo_json_type.dart';

class FeatureCollection extends GeoJSONObject {
  List<Feature> features;
  FeatureCollection({@required this.features})
      : assert(features != null),
        super(GeoJSONType.FeatureCollection);

  toGeoJSON() {
    return {
      '\"type\"': '\"${type.toShortString()}\"',
      '\"features\"': features.map((e) => e.toGeoJSON()).toList()
    };
  }
}
