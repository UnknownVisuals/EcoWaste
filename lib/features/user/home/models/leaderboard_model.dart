class LeaderboardModel {
  LeaderboardModel({
    required this.rank,
    required this.userId,
    required this.userName,
    required this.totalPoints,
    this.avatar,
    this.location,
    this.badgeLevel,
  });

  final int rank, totalPoints;
  final String userId, userName;
  final String? avatar, location, badgeLevel;

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
      rank: json['rank'] ?? 0,
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      totalPoints: json['totalPoints'] ?? 0,
      avatar: json['avatar'],
      location: json['location'],
      badgeLevel: json['badgeLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rank': rank,
      'userId': userId,
      'userName': userName,
      'totalPoints': totalPoints,
      'avatar': avatar,
      'location': location,
      'badgeLevel': badgeLevel,
    };
  }

  // Helper methods
  bool get isTopThree => rank <= 3;
  String get rankSuffix {
    if (rank == 1) return 'st';
    if (rank == 2) return 'nd';
    if (rank == 3) return 'rd';
    return 'th';
  }

  String get formattedRank => '$rank$rankSuffix';
}
