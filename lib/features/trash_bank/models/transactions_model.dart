import 'package:eco_waste/features/trash_bank/models/waste_category_model.dart';

class TransactionUser {
  TransactionUser({required this.id, required this.name});

  final String id;
  final String name;

  factory TransactionUser.fromJson(Map<String, dynamic> json) {
    return TransactionUser(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class TransactionModel {
  TransactionModel({
    required this.id,
    required this.userId,
    required this.wasteCategoryId,
    required this.type,
    required this.status,
    required this.locationDetail,
    required this.scheduledDate,
    required this.photos,
    required this.locationId,
    required this.createdAt,
    required this.updatedAt,
    this.actualWeight,
    this.points = 0,
    this.notes,
    this.processedByUserId,
    this.completedDate,
    required this.wasteCategory,
    required this.user,
  });

  final String id, userId, wasteCategoryId, type, status, locationDetail;
  final DateTime scheduledDate, createdAt, updatedAt;
  final List<String> photos;
  final int points;
  final String locationId;
  final double? actualWeight;
  final String? notes, processedByUserId;
  final DateTime? completedDate;
  final WasteCategoryModel wasteCategory;
  final TransactionUser user;

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      wasteCategoryId: json['wasteCategoryId']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      locationDetail: json['locationDetail']?.toString() ?? '',
      scheduledDate: DateTime.parse(
        json['scheduledDate']?.toString() ?? DateTime.now().toIso8601String(),
      ),
      photos: List<String>.from(json['photos'] ?? []),
      locationId: json['locationId']?.toString() ?? '',
      createdAt: DateTime.parse(
        json['createdAt']?.toString() ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt']?.toString() ?? DateTime.now().toIso8601String(),
      ),
      actualWeight: json['actualWeight']?.toDouble(),
      points: (json['points'] is int)
          ? json['points']
          : int.tryParse(json['points']?.toString() ?? '0') ?? 0,
      notes: json['notes']?.toString(),
      processedByUserId: json['processedByUserId']?.toString(),
      completedDate: json['completedDate'] != null
          ? DateTime.parse(json['completedDate'].toString())
          : null,
      wasteCategory: WasteCategoryModel.fromJson(json['wasteCategory'] ?? {}),
      user: TransactionUser.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'wasteCategoryId': wasteCategoryId,
      'type': type,
      'status': status,
      'locationDetail': locationDetail,
      'scheduledDate': scheduledDate.toIso8601String(),
      'photos': photos,
      'locationId': locationId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'actualWeight': actualWeight,
      'points': points,
      'notes': notes,
      'processedByUserId': processedByUserId,
      'completedDate': completedDate?.toIso8601String(),
      'wasteCategory': wasteCategory.toJson(),
      'user': user.toJson(),
    };
  }
}
