class RewardsHistoryModel {
  RewardsHistoryModel({
    required this.id,
    required this.userId,
    required this.rewardId,
    required this.pointsSpent,
    required this.status,
    required this.redeemedAt,
    required this.reward,
  });

  final String id, userId, rewardId, status;
  final DateTime? redeemedAt;
  final int pointsSpent;
  final RewardSummary reward;

  factory RewardsHistoryModel.fromJson(Map<String, dynamic> json) {
    final dynamic redeemedAtRaw = json['redeemedAt'];
    DateTime? redeemedAt;

    if (redeemedAtRaw is String && redeemedAtRaw.isNotEmpty) {
      redeemedAt = DateTime.tryParse(redeemedAtRaw)?.toLocal();
    } else if (redeemedAtRaw is DateTime) {
      redeemedAt = redeemedAtRaw.toLocal();
    }

    return RewardsHistoryModel(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      rewardId: json['rewardId']?.toString() ?? '',
      pointsSpent: json['pointsSpent'] is int
          ? json['pointsSpent'] as int
          : int.tryParse(json['pointsSpent']?.toString() ?? '0') ?? 0,
      status: json['status']?.toString() ?? '',
      redeemedAt: redeemedAt,
      reward: RewardSummary.fromJson(json['reward'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'rewardId': rewardId,
      'pointsSpent': pointsSpent,
      'status': status,
      'redeemedAt': redeemedAt?.toUtc().toIso8601String(),
      'reward': reward.toJson(),
    };
  }
}

class RewardSummary {
  RewardSummary({required this.name});

  final String name;

  factory RewardSummary.fromJson(Map<String, dynamic> json) {
    return RewardSummary(name: json['name']?.toString() ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
