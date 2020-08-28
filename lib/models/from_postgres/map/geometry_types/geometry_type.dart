enum GeoJSONGeometryType {
  Point,
  MultiPoint,
  LineString,
  MultiLineString,
  Polygon,
  MultiPolygon,
  GeometryCollection
}

extension GeometryTypeShortString on GeoJSONGeometryType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
