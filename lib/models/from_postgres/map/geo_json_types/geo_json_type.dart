enum GeoJSONType {
  Feature,
  FeatureCollection,
  Point,
  MultiPoint,
  LineString,
  MultiLineString,
  Polygon,
  MultiPolygon,
  GeometryCollection
}

extension GeoJSONTypeShortString on GeoJSONType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
