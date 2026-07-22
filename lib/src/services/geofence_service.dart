import 'dart:math';

class GeofenceService {
  const GeofenceService();

  double distanceFromPlantMeters({
    required double currentLat,
    required double currentLng,
    required double plantLat,
    required double plantLng,
  }) {
    const earthRadiusMeters = 6371000.0;
    final dLat = _toRadians(currentLat - plantLat);
    final dLng = _toRadians(currentLng - plantLng);
    final a = pow(sin(dLat / 2), 2) +
        cos(_toRadians(plantLat)) *
            cos(_toRadians(currentLat)) *
            pow(sin(dLng / 2), 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusMeters * c;
  }

  bool isInsideGeofence({
    required double currentLat,
    required double currentLng,
    required double plantLat,
    required double plantLng,
    required double radiusMeters,
  }) {
    return distanceFromPlantMeters(
          currentLat: currentLat,
          currentLng: currentLng,
          plantLat: plantLat,
          plantLng: plantLng,
        ) <=
        radiusMeters;
  }

  double _toRadians(double degrees) => degrees * pi / 180;
}
