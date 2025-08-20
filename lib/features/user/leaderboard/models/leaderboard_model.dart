class LeaderboardModel {
  LeaderboardModel({
    required this.id,
    required this.name,
    required this.points,
    this.avatar,
    required this.locationId,
    required this.rank,
    required this.userId,
  });

  final String id;
  final String name;
  final int points;
  final String? avatar;
  final String locationId;
  final int rank;
  final String userId;

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      points: json['points'] ?? 0,
      avatar: json['avatar'],
      locationId: json['locationId'] ?? '',
      rank: json['rank'] ?? 0,
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'points': points,
      'avatar': avatar,
      'locationId': locationId,
      'rank': rank,
      'userId': userId,
    };
  }
}
