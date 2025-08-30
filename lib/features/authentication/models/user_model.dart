class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.locationId,
    required this.points,
    required this.avatar,
    required this.rt,
    required this.rw,
  });

  final String id, name, email, role, locationId, avatar, rt, rw;
  late int points;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      locationId: json['locationId']?.toString() ?? '',
      points: (json['points'] is int)
          ? json['points']
          : int.tryParse(json['points']?.toString() ?? '0') ?? 0,
      avatar: json['avatar']?.toString() ?? '',
      rt: json['rt']?.toString() ?? '',
      rw: json['rw']?.toString() ?? '',
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
      'rt': rt,
      'rw': rw,
    };
  }
}
