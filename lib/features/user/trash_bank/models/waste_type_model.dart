class WasteCategoryModel {
  WasteCategoryModel({
    required this.id,
    required this.name,
    required this.pointsPerKg,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  final String id, name;
  final int pointsPerKg;
  final String? description, createdAt, updatedAt;

  factory WasteCategoryModel.fromJson(Map<String, dynamic> json) {
    return WasteCategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      pointsPerKg: json['pointsPerKg'] ?? 0,
      description: json['description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pointsPerKg': pointsPerKg,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
