import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'firestore_service.dart';
import 'geofence_service.dart';

class AttendanceService {
  AttendanceService({
    required this.firestoreService,
    this.geofenceService = const GeofenceService(),
  });

  final FirestoreService firestoreService;
  final GeofenceService geofenceService;

  Future<AttendanceResult> checkIn({
    required String empCode,
    required String department,
    required String shiftId,
    required double plantLat,
    required double plantLng,
    required double radiusMeters,
  }) async {
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return AttendanceResult.permissionDenied();
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final inside = geofenceService.isInsideGeofence(
      currentLat: position.latitude,
      currentLng: position.longitude,
      plantLat: plantLat,
      plantLng: plantLng,
      radiusMeters: radiusMeters,
    );

    if (!inside) return AttendanceResult.outsideGeofence();

    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    await firestoreService.saveAttendance({
      'emp_code': empCode,
      'department': department,
      'date': today,
      'shift_id': shiftId,
      'check_in_time': FieldValue.serverTimestamp(),
      'check_in_location': GeoPoint(position.latitude, position.longitude),
      'geofence_status': 'inside',
      'status': 'present',
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    });

    return AttendanceResult.success();
  }
}

class AttendanceResult {
  AttendanceResult._(this.status);

  final AttendanceResultStatus status;

  factory AttendanceResult.success() => AttendanceResult._(AttendanceResultStatus.success);
  factory AttendanceResult.permissionDenied() => AttendanceResult._(AttendanceResultStatus.permissionDenied);
  factory AttendanceResult.outsideGeofence() => AttendanceResult._(AttendanceResultStatus.outsideGeofence);
}

enum AttendanceResultStatus {
  success,
  permissionDenied,
  outsideGeofence,
}
