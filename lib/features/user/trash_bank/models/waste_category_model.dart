class WasteCategoryModel {
  WasteCategoryModel({
    required this.id,
    required this.name,
    required this.pointsPerKg,
    required this.description,
    required this.color,
    required this.locationId,
  });

  final String id, name, description, color, locationId;
  final int pointsPerKg;

  factory WasteCategoryModel.fromJson(Map<String, dynamic> json) {
    return WasteCategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      pointsPerKg: (json['pointsPerKg'] is int)
          ? json['pointsPerKg']
          : int.tryParse(json['pointsPerKg']?.toString() ?? '0') ?? 0,
      color: json['color']?.toString() ?? '',
      locationId: json['locationId']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pointsPerKg': pointsPerKg,
      'color': color,
      'locationId': locationId,
    };
  }
}
