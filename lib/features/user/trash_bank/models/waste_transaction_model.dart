class WasteTransactionModel {
  WasteTransactionModel({
    required this.id,
    required this.userId,
    required this.tps3rId,
    required this.status,
    required this.totalWeight,
    required this.totalPoints,
    required this.items,
    this.createdAt,
    this.processedAt,
    this.cancelledAt,
  });

  final String id, userId, tps3rId, status;
  final double totalWeight;
  final int totalPoints;
  final List<WasteTransactionItem> items;
  final String? createdAt, processedAt, cancelledAt;

  factory WasteTransactionModel.fromJson(Map<String, dynamic> json) {
    return WasteTransactionModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      tps3rId: json['tps3rId'] ?? '',
      status: json['status'] ?? 'PENDING',
      totalWeight: (json['totalWeight'] ?? 0).toDouble(),
      totalPoints: json['totalPoints'] ?? 0,
      items: json['items'] != null
          ? (json['items'] as List)
                .map((item) => WasteTransactionItem.fromJson(item))
                .toList()
          : [],
      createdAt: json['createdAt'],
      processedAt: json['processedAt'],
      cancelledAt: json['cancelledAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'tps3rId': tps3rId,
      'status': status,
      'totalWeight': totalWeight,
      'totalPoints': totalPoints,
      'items': items.map((item) => item.toJson()).toList(),
      'createdAt': createdAt,
      'processedAt': processedAt,
      'cancelledAt': cancelledAt,
    };
  }

  // Helper methods
  bool get isPending => status == 'PENDING';
  bool get isProcessed => status == 'PROCESSED';
  bool get isCancelled => status == 'CANCELLED';
}

class WasteTransactionItem {
  WasteTransactionItem({
    required this.categoryId,
    required this.weight,
    this.categoryName,
    this.pointsPerKg,
    this.totalPoints,
  });

  final String categoryId;
  final double weight;
  final String? categoryName;
  final int? pointsPerKg, totalPoints;

  factory WasteTransactionItem.fromJson(Map<String, dynamic> json) {
    return WasteTransactionItem(
      categoryId: json['categoryId'] ?? '',
      weight: (json['weight'] ?? 0).toDouble(),
      categoryName: json['categoryName'],
      pointsPerKg: json['pointsPerKg'],
      totalPoints: json['totalPoints'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'weight': weight,
      'categoryName': categoryName,
      'pointsPerKg': pointsPerKg,
      'totalPoints': totalPoints,
    };
  }
}

// Model untuk create transaction request
class CreateWasteTransactionModel {
  CreateWasteTransactionModel({
    required this.userId,
    required this.tps3rId,
    required this.items,
  });

  final String userId, tps3rId;
  final List<WasteTransactionItem> items;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'tps3rId': tps3rId,
      'items': items
          .map((item) => {'categoryId': item.categoryId, 'weight': item.weight})
          .toList(),
    };
  }
}
