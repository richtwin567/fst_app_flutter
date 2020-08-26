enum GeometryType {
  Point,
  MultiPoint,
  LineString,
  MultiLineString,
  Polygon,
  MultiPolygon,
  GeometryCollection
}

extension GeometryTypeShortString on GeometryType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
