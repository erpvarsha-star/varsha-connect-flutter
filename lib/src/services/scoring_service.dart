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
}
