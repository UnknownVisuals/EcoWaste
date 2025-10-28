class RewardsModel {
  RewardsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pointsRequired,
    required this.stock,
    this.imageUrl,
    required this.locationId,
  });

  final String id, name, description, locationId;
  final String? imageUrl;
  final int pointsRequired, stock;

  factory RewardsModel.fromJson(Map<String, dynamic> json) {
    return RewardsModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      pointsRequired: (json['pointsRequired'] is int)
          ? json['pointsRequired']
          : int.tryParse(json['pointsRequired']?.toString() ?? '0') ?? 0,
      stock: (json['stock'] is int)
          ? json['stock']
          : int.tryParse(json['stock']?.toString() ?? '0') ?? 0,
      imageUrl: json['imageUrl'] != null ? json['imageUrl']?.toString() : null,
      locationId: json['locationId']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pointsRequired': pointsRequired,
      'stock': stock,
      'imageUrl': imageUrl,
      'locationId': locationId,
    };
  }
}
