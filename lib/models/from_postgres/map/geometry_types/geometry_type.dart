// TODO: document @richtwin567
enum GeoJsonGeometryType {
  point,
  multiPoint,
  lineString,
  multiLineString,
  polygon,
  multiPolygon,
  geometryCollection
}

extension GeometryTypeShortString on GeoJsonGeometryType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
