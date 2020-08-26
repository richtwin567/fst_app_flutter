import 'package:fst_app_flutter/models/from_postgres/map/geo_json_types/geo_json_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geo_json_types/geo_json_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/line_string.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/multi_point.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/point.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/polygon.dart';
import 'package:fst_app_flutter/models/from_postgres/map/properties.dart';

class Feature extends GeoJSONObject {
  GeometryObject geometry;
  Properties properties;
  int id;

  GeometryType _stringToGeometryType(str) {
    switch (str) {
      case "GeometryCollection":
        return GeometryType.GeometryCollection;
        break;
      case "LineString":
        return GeometryType.LineString;
        break;
      case 'MultiLineString':
        return GeometryType.MultiLineString;
        break;
      case 'MultiPoint':
        return GeometryType.MultiPoint;
        break;
      case 'MultiPolygon':
        return GeometryType.MultiPolygon;
        break;
      case 'Polygon':
        return GeometryType.Polygon;
        break;
      default:
        return GeometryType.Point;
        break;
    }
  }

  Feature(dynamic feature) : super(GeoJSONType.Feature) {
    properties = Properties(
        title: feature['code'],
        description: feature['title'],
        associatedWith: feature['associated_with'],
        altName: feature['alt_name']);
    id = feature['id'];
    var uknGeometry = feature['geometry'];
    var newCoords = uknGeometry['coordinates'];
    print(newCoords);
    switch (_stringToGeometryType(uknGeometry['geometry_type'])) {
      case GeometryType.Point:
        geometry = Point(coordsJSON: newCoords);
        break;
      case GeometryType.MultiPoint:
        geometry = MultiPoint(coordsJSON: newCoords);
        break;
      case GeometryType.LineString:
        geometry = LineString(coordsJSON: newCoords);
        break;
      case GeometryType.MultiLineString:
        throw UnimplementedError();
        //geometry = MultiLineString(coordsJSON: newCoords);
        break;
      case GeometryType.Polygon:
        geometry = Polygon(coordsJSON: newCoords);
        break;
      case GeometryType.MultiPolygon:
        throw UnimplementedError();
        //geometry = MultiPolygon(coordsJSON: newCoords);
        break;
      case GeometryType.GeometryCollection:
        throw UnimplementedError();
        break;
    }
  }

  Map toGeoJSON() {
    return {
      '\"id\"': id,
      '\"type\"': '\"${type.toShortString()}\"',
      '\"geometry\"': geometry.toGeoJSON(),
      '\"properties\"': properties.toGeoJSON()
    };
  }

}
