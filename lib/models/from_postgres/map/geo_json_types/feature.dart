import 'package:fst_app_flutter/models/from_postgres/contact/contact_model.dart';
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

class Feature extends GeoJSONObject {
  GeoJSONGeometryObject geometry;
  Properties properties;
  int id;

  

  Feature(dynamic feature) : super(GeoJSONType.Feature) {
    properties = Properties(
        title: feature['code'],
        description: feature['title'],
        associatedWith: stringToDepartment(feature['associated_with']),
        altName: feature['alt_name']);
    id = feature['id'];
    var uknGeometry = feature['geometry'];
    var newCoords = uknGeometry['coordinates'];
    //print(newCoords);
    switch (stringToGeometryType(uknGeometry['geometry_type'])) {
      case GeoJSONGeometryType.Point:
        geometry = GeoJSONPoint(coordsJSON: newCoords);
        break;
      case GeoJSONGeometryType.MultiPoint:
        geometry = GeoJSONMultiPoint(coordsJSON: newCoords);
        break;
      case GeoJSONGeometryType.LineString:
        geometry = GeoJSONLineString(coordsJSON: newCoords);
        break;
      case GeoJSONGeometryType.MultiLineString:
        throw UnimplementedError();
        //geometry = MultiLineString(coordsJSON: newCoords);
        break;
      case GeoJSONGeometryType.Polygon:
        geometry = GeoJSONPolygon(coordsJSON: newCoords);
        break;
      case GeoJSONGeometryType.MultiPolygon:
        throw UnimplementedError();
        //geometry = MultiPolygon(coordsJSON: newCoords);
        break;
      case GeoJSONGeometryType.GeometryCollection:
        throw UnimplementedError();
        break;
    }
  }

  @override
  toGeoJSONFile() {
    return {
      '\"id\"': id,
      '\"type\"': '\"${type.toShortString()}\"',
      '\"geometry\"': geometry.toGeoJSONFile(),
      '\"properties\"': properties.toGeoJSONFile()
    };
  }

  @override
  Map<String, Object> toGeoJSON() {
    return {
      'id': id,
      'type': type.toShortString(),
      'geometry': geometry.toGeoJSON(),
      'properties': properties.toGeoJSON()
    };
  }
}
