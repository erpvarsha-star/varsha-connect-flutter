import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  StaffProfile? profile;

  bool get isLoggedIn => profile != null;

  void setProfile(StaffProfile value) {
    profile = value;
    notifyListeners();
  }

  bool get canScore {
    final role = profile?.role;
    return role == 'manager' || role == 'plant_head';
  }
}

class StaffProfile {
  StaffProfile({
    required this.empCode,
    required this.name,
    required this.role,
    required this.department,
  });

  final String empCode;
  final String name;
  final String role;
  final String department;
}
