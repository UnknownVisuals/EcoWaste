// Legacy model - will be replaced by WasteTransactionModel
// Keeping for backward compatibility during transition
class DepositModel {
  DepositModel({
    required this.id,
    required this.userId,
    required this.tps3rId,
    required this.totalWeight,
    required this.categoryName,
    required this.totalPoints,
    required this.createdAt,
    required this.status,
    this.processedAt,
  });

  final String id, userId, tps3rId, categoryName, status;
  final double totalWeight;
  final int totalPoints;
  final DateTime createdAt;
  final DateTime? processedAt;

  factory DepositModel.fromJson(Map<String, dynamic> json) {
    return DepositModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      tps3rId: json['tps3rId'] ?? '',
      totalWeight: (json['totalWeight'] ?? 0).toDouble(),
      categoryName: json['categoryName'] ?? '',
      totalPoints: json['totalPoints'] ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt']).toLocal()
          : DateTime.now(),
      status: json['status'] ?? 'PENDING',
      processedAt: json['processedAt'] != null
          ? DateTime.parse(json['processedAt']).toLocal()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'tps3rId': tps3rId,
      'totalWeight': totalWeight,
      'categoryName': categoryName,
      'totalPoints': totalPoints,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'processedAt': processedAt?.toIso8601String(),
    };
  }

  // Helper methods
  bool get isPending => status == 'PENDING';
  bool get isProcessed => status == 'PROCESSED';
  bool get isCancelled => status == 'CANCELLED';
}
