enum TaskStatus {
  assigned,
  acknowledged,
  inProgress,
  done,
  cancelled,
  overdue;

  String get label {
    return switch (this) {
      TaskStatus.assigned => 'Assigned',
      TaskStatus.acknowledged => 'Acknowledged',
      TaskStatus.inProgress => 'In Progress',
      TaskStatus.done => 'Done',
      TaskStatus.cancelled => 'Cancelled',
      TaskStatus.overdue => 'Overdue',
    };
  }
}
