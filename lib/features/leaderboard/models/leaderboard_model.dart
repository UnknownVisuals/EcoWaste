class LeaderboardModel {
  LeaderboardModel({
    required this.id,
    required this.name,
    required this.points,
    required this.avatar,
    required this.locationId,
    required this.rank,
    required this.userId,
  });

  final String id, name, avatar, locationId, userId;
  final int points, rank;

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      points: (json['points'] is int)
          ? json['points']
          : int.tryParse(json['points']?.toString() ?? '0') ?? 0,
      avatar: json['avatar']?.toString() ?? '',
      locationId: json['locationId']?.toString() ?? '',
      rank: (json['rank'] is int)
          ? json['rank']
          : int.tryParse(json['rank']?.toString() ?? '0') ?? 0,
      userId: json['userId']?.toString() ?? '',
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
