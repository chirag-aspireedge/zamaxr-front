enum LeaderboardTrend {
  up,
  neutral,
  down,
}

class LeaderboardStudentModel {
  final int rank;
  final String name;
  final String score;
  final String? subtitle;
  final String avatarAsset;
  final String delta;
  final LeaderboardTrend trend;

  const LeaderboardStudentModel({
    required this.rank,
    required this.name,
    required this.score,
    this.subtitle,
    required this.avatarAsset,
    required this.delta,
    required this.trend,
  });
}
