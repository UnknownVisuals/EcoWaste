class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.desaId,
    required this.poin,
    this.role = 'WARGA',
  });

  final String id, email, username, desaId, role;
  late int poin;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      desaId: json['desaId'],
      poin: json['poin'] ?? 0,
      role: json['role'] ?? 'WARGA',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'desaId': desaId,
      'poin': poin,
      'role': role,
    };
  }
}
