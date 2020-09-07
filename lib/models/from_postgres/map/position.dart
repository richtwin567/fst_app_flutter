import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GeoJsonPosition {
  double _longitude; //MUST COME BEFORE LATITUDE

  double _latitude;

  double _elevation;

  double get latitude => _latitude;

  double get longitude => _longitude;

  double get elevation => _elevation;

  GeoJsonPosition(
      {@required double newLongitude,
      @required double newLatitude,
      double elevation})
      : assert(newLatitude != null && newLongitude != null) {
    _elevation = elevation;
    _longitude = newLongitude;
    _latitude = newLatitude;
  }

  @override
  int get hashCode =>
      longitude.hashCode ^ latitude.hashCode ^ elevation.hashCode;

  //cartesianLine(lon, lat) => (lon0 + (lon1 - lon0) * t, lat0 + (lat1 - lat0) * t)

  @override
  operator ==(o) =>
      o is GeoJsonPosition &&
      o.longitude == longitude &&
      o.latitude == latitude &&
      o.elevation == elevation;

  toGeoJson() => [latitude, longitude];

  
  List<LatLng> extractLatLng() {
    return [LatLng(latitude, longitude)];
  }
}
