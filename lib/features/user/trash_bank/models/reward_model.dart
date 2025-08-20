class RewardModel {
  RewardModel({
    required this.id,
    required this.name,
    required this.pointsRequired,
    this.description,
    this.imageUrl,
    this.category,
    this.stock,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  final String id, name;
  final int pointsRequired;
  final String? description, imageUrl, category;
  final int? stock;
  final bool? isActive;
  final String? createdAt, updatedAt;

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      pointsRequired: json['pointsRequired'] ?? 0,
      description: json['description'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      stock: json['stock'],
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pointsRequired': pointsRequired,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'stock': stock,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Helper methods
  bool get isAvailable => (isActive ?? true) && (stock ?? 1) > 0;
  bool get isOutOfStock => stock != null && stock! <= 0;
}

// Model untuk redeem reward
class RedeemRewardModel {
  RedeemRewardModel({required this.userId, required this.rewardId, this.notes});

  final String userId, rewardId;
  final String? notes;

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'rewardId': rewardId, 'notes': notes};
  }
}

// Model untuk reward redemption history
class RewardRedemptionModel {
  RewardRedemptionModel({
    required this.id,
    required this.userId,
    required this.rewardId,
    required this.pointsUsed,
    required this.status,
    this.rewardName,
    this.notes,
    this.redeemedAt,
    this.processedAt,
  });

  final String id, userId, rewardId, status;
  final int pointsUsed;
  final String? rewardName, notes, redeemedAt, processedAt;

  factory RewardRedemptionModel.fromJson(Map<String, dynamic> json) {
    return RewardRedemptionModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      rewardId: json['rewardId'] ?? '',
      pointsUsed: json['pointsUsed'] ?? 0,
      status: json['status'] ?? 'PENDING',
      rewardName: json['rewardName'],
      notes: json['notes'],
      redeemedAt: json['redeemedAt'],
      processedAt: json['processedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'rewardId': rewardId,
      'pointsUsed': pointsUsed,
      'status': status,
      'rewardName': rewardName,
      'notes': notes,
      'redeemedAt': redeemedAt,
      'processedAt': processedAt,
    };
  }

  // Helper methods
  bool get isPending => status == 'PENDING';
  bool get isProcessed => status == 'PROCESSED';
  bool get isCancelled => status == 'CANCELLED';
}
