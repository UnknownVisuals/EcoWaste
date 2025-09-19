class UserListModel {
  UserListModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.points,
  });

  final String id, name, email, role;
  final int points;

  factory UserListModel.fromJson(Map<String, dynamic> json) {
    return UserListModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      points: json['points'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'points': points,
    };
  }
}
