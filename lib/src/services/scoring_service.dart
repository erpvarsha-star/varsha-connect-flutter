class ScoringService {
  const ScoringService();

  double compositeScore({
    required double attendanceScore,
    required double taskScore,
    required double formScore,
    required double managerObservationScore,
  }) {
    final taskAndFormScore = ((taskScore + formScore) / 2).clamp(0, 100);
    return (attendanceScore * 0.40) +
        (taskAndFormScore * 0.40) +
        (managerObservationScore * 0.20);
  }

  int attendancePoints({required int lateMinutes, required bool absentUnannounced}) {
    if (absentUnannounced) return -5;
    if (lateMinutes <= 0) return 10;
    if (lateMinutes <= 30) return 5;
    return 2;
  }

  int monthlyPerfectAttendanceBonus({required bool perfectAttendance}) {
    return perfectAttendance ? 50 : 0;
  }

  int observationPoints(int observationCount) {
    return observationCount * 15;
  }
}
