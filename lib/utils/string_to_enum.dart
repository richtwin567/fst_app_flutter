import 'package:fst_app_flutter/models/enums/department.dart';
import 'package:fst_app_flutter/models/from_postgres/contact/contact_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';

Department stringToDepartment (str){
  switch (str) {
      case 'CHEM':
        return Department.CHEM;
        break;
      case 'COMP':
        return Department.COMP;
        break;
      case 'GEO':
        return Department.GEO;
        break;
      case 'LIFE':
        return Department.LIFE;
        break;
      case 'MATH':
        return Department.MATH;
        break;
      case 'PHYS':
        return Department.PHYS;
        break;
      default:
        return Department.OTHER;
        break;
    }
}

ContactType stringToContactType(str){
  switch (str) {
      case 'EMERGENCY':
        return ContactType.EMERGENCY;
        break;
      case 'OFFICE':
        return ContactType.OFFICE;
        break;
      case 'FACULTY_STAFF':
        return ContactType.FACULTY_STAFF;
        break;
      default:
        return ContactType.OTHER;
        break;
    }
}

GeoJSONGeometryType stringToGeometryType(str) {
    switch (str) {
      case "GeometryCollection":
        return GeoJSONGeometryType.GeometryCollection;
        break;
      case "LineString":
        return GeoJSONGeometryType.LineString;
        break;
      case 'MultiLineString':
        return GeoJSONGeometryType.MultiLineString;
        break;
      case 'MultiPoint':
        return GeoJSONGeometryType.MultiPoint;
        break;
      case 'MultiPolygon':
        return GeoJSONGeometryType.MultiPolygon;
        break;
      case 'Polygon':
        return GeoJSONGeometryType.Polygon;
        break;
      default:
        return GeoJSONGeometryType.Point;
        break;
    }
  }