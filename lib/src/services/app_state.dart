import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  StaffProfile? profile = StaffProfile(
    empCode: 'VFL4001',
    name: 'Demo Worker',
    role: 'worker',
    department: 'Forge Shop',
  );

  bool get isLoggedIn => profile != null;

  void setProfile(StaffProfile value) {
    profile = value;
    notifyListeners();
  }

  bool get canScore {
    final role = profile?.role;
    return role == 'manager' || role == 'plant_head' || role == 'owner';
  }

  void switchRole(String role) {
    final defaults = switch (role) {
      'supervisor' => ('VFL2001', 'Demo Supervisor', 'Forge Shop'),
      'manager' => ('VFL1001', 'Demo Manager', 'Operations'),
      'hr' => ('VFL1002', 'Demo HR Admin', 'HR'),
      'owner' => ('OWN001', 'Owner View', 'Management'),
      _ => ('VFL4001', 'Demo Worker', 'Forge Shop'),
    };
    profile = StaffProfile(
      empCode: defaults.$1,
      name: defaults.$2,
      role: role,
      department: defaults.$3,
    );
    notifyListeners();
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
