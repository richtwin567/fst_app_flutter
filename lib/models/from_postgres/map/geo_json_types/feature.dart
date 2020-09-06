import 'package:fst_app_flutter/models/from_postgres/map/geo_json_types/geo_json_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geo_json_types/geo_json_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/line_string.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/multi_point.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/point.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/polygon.dart';
import 'package:fst_app_flutter/models/from_postgres/map/properties.dart';
import 'package:fst_app_flutter/utils/string_to_enum.dart';

class Feature extends GeoJsonObject {
  GeoJsonGeometryObject geometry;
  Properties properties;
  int id;

  

  Feature(dynamic feature) : super(GeoJsonType.feature) {
    properties = Properties(
        title: feature['code'],
        description: feature['title'],
        associatedWith: stringToDepartment(feature['associated_with']),
        altName: feature['alt_name']);
    id = feature['id'];
    var uknGeometry = feature['geometry'];
    var newCoords = uknGeometry['coordinates'];
    switch (stringToGeometryType(uknGeometry['geometry_type'])) {
      case GeoJsonGeometryType.point:
        geometry = GeoJsonPoint(coordsJson: newCoords);
        break;
      case GeoJsonGeometryType.multiPoint:
        geometry = GeoJsonMultiPoint(coordsJson: newCoords);
        break;
      case GeoJsonGeometryType.lineString:
        geometry = GeoJsonLineString(coordsJson: newCoords);
        break;
      case GeoJsonGeometryType.multiLineString:
        throw UnimplementedError();
        //geometry = MultiLineString(coordsJSON: newCoords);
        break;
      case GeoJsonGeometryType.polygon:
        geometry = GeoJsonPolygon(coordsJson: newCoords);
        break;
      case GeoJsonGeometryType.multiPolygon:
        throw UnimplementedError();
        //geometry = MultiPolygon(coordsJSON: newCoords);
        break;
      case GeoJsonGeometryType.geometryCollection:
        throw UnimplementedError();
        break;
    }
  }

  @override
  toGeoJsonFile() {
    return {
      '\"id\"': id,
      '\"type\"': '\"${type.toShortString()}\"',
      '\"geometry\"': geometry.toGeoJsonFile(),
      '\"properties\"': properties.toGeoJsonFile()
    };
  }

  @override
  Map<String, Object> toGeoJson() {
    return {
      'id': id,
      'type': type.toShortString(),
      'geometry': geometry.toGeoJson(),
      'properties': properties.toGeoJson()
    };
  }
}
