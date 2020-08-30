import 'package:fst_app_flutter/models/enums/department.dart';
import 'package:fst_app_flutter/models/from_postgres/contact/contact_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';

Department stringToDepartment(str) {
  switch (str) {
    case 'BIOCHEM':
      return Department.biochem;
      break;
    case 'CHEM':
      return Department.chem;
      break;
    case 'COMP':
      return Department.comp;
      break;
    case 'GEO':
      return Department.geo;
      break;
    case 'LIFE':
      return Department.life;
      break;
    case 'MATH':
      return Department.math;
      break;
    case 'PHYS':
      return Department.phys;
      break;
    default:
      return Department.other;
      break;
  }
}

ContactType stringToContactType(str) {
  switch (str) {
    case 'EMERGENCY':
      return ContactType.emergency;
      break;
    case 'OFFICE':
      return ContactType.office;
      break;
    case 'FACULTY_STAFF':
      return ContactType.facultyStaff;
      break;
    default:
      return ContactType.other;
      break;
  }
}

GeoJsonGeometryType stringToGeometryType(str) {
  switch (str) {
    case "GeometryCollection":
      return GeoJsonGeometryType.geometryCollection;
      break;
    case "LineString":
      return GeoJsonGeometryType.lineString;
      break;
    case 'MultiLineString':
      return GeoJsonGeometryType.multiLineString;
      break;
    case 'MultiPoint':
      return GeoJsonGeometryType.multiPoint;
      break;
    case 'MultiPolygon':
      return GeoJsonGeometryType.multiPolygon;
      break;
    case 'Polygon':
      return GeoJsonGeometryType.polygon;
      break;
    default:
      return GeoJsonGeometryType.point;
      break;
  }
}
