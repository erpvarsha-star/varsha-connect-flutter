enum UserRole {
  plantHead,
  manager,
  supervisor,
  shiftIncharge;

  static UserRole fromValue(String value) {
    return switch (value) {
      'plant_head' => UserRole.plantHead,
      'manager' => UserRole.manager,
      'supervisor' => UserRole.supervisor,
      _ => UserRole.shiftIncharge,
    };
  }

  bool get canScore => this == UserRole.manager || this == UserRole.plantHead;
  bool get canAssignTasks => this != UserRole.shiftIncharge;
}
