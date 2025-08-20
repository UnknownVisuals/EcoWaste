class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.locationId,
    required this.points,
    required this.avatar,
    this.tps3rId,
  });

  final String id, name, email, role, locationId, avatar;
  final String? tps3rId;
  final int points;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'USER',
      locationId: json['locationId'] ?? '',
      points: json['points'] ?? 0,
      avatar: json['avatar'] ?? '',
      tps3rId: json['tps3rId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'locationId': locationId,
      'points': points,
      'avatar': avatar,
      'tps3rId': tps3rId,
    };
  }
}
