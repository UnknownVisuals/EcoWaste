import 'package:eco_waste/features/user/trash_bank/models/waste_category_model.dart';

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
    this.points,
    this.notes,
    this.processedByUserId,
    this.completedDate,
    this.wasteCategory,
    this.user,
  });

  final String id;
  final String userId;
  final String wasteCategoryId;
  final String type;
  final String status;
  final String locationDetail;
  final DateTime scheduledDate;
  final List<String> photos;
  final String locationId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double? actualWeight;
  final int? points;
  final String? notes;
  final String? processedByUserId;
  final DateTime? completedDate;
  final WasteCategoryModel? wasteCategory;
  final TransactionUser? user;

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      wasteCategoryId: json['wasteCategoryId']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      locationDetail: json['locationDetail']?.toString() ?? '',
      scheduledDate: json['scheduledDate'] != null
          ? DateTime.parse(json['scheduledDate']).toLocal()
          : DateTime.now(),
      photos: json['photos'] != null ? List<String>.from(json['photos']) : [],
      locationId: json['locationId']?.toString() ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt']).toLocal()
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt']).toLocal()
          : DateTime.now(),
      // Handle both 'actualWeight' and 'weighedWeight' from API
      actualWeight: json['actualWeight'] != null
          ? (json['actualWeight'] is double
                ? json['actualWeight']
                : double.tryParse(json['actualWeight'].toString()))
          : json['weighedWeight'] != null
          ? (json['weighedWeight'] is double
                ? json['weighedWeight']
                : double.tryParse(json['weighedWeight'].toString()))
          : null,
      points: json['points'] != null
          ? (json['points'] is int
                ? json['points']
                : int.tryParse(json['points'].toString()) ?? 0)
          : null,
      notes: json['notes']?.toString(),
      processedByUserId: json['processedByUserId']?.toString(),
      completedDate: json['completedDate'] != null
          ? DateTime.parse(json['completedDate']).toLocal()
          : null,
      // Handle both 'wasteCategory' and 'tps3r' from API
      wasteCategory: json['wasteCategory'] != null
          ? WasteCategoryModel.fromJson(
              json['wasteCategory'] as Map<String, dynamic>,
            )
          : json['tps3r'] != null
          ? WasteCategoryModel.fromJson(json['tps3r'] as Map<String, dynamic>)
          : null,
      user: json['user'] != null
          ? TransactionUser.fromJson(json['user'] as Map<String, dynamic>)
          : null,
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
      if (actualWeight != null) 'actualWeight': actualWeight,
      if (points != null) 'points': points,
      if (notes != null) 'notes': notes,
      if (processedByUserId != null) 'processedByUserId': processedByUserId,
      if (completedDate != null)
        'completedDate': completedDate!.toIso8601String(),
    };
  }
}
