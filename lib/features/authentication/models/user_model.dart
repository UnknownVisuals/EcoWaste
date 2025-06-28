class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.desaId,
    required this.poin,
  });

  final String id, email, username, desaId;
  late int poin;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      desaId: json['desaId'],
      poin: json['poin'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'desaId': desaId,
      'poin': poin,
    };
  }
}
