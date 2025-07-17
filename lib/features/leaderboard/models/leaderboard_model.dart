class LeaderboardModel {
  LeaderboardModel({
    required this.id,
    required this.totalPoin,
    required this.jumlahPengumpulan,
    required this.available,
    required this.poinSaatIni,
    required this.userId,
    required this.user,
  });

  final String id, userId;
  final int totalPoin, poinSaatIni, jumlahPengumpulan;
  final bool available;
  final User user;

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
      id: json['id'],
      totalPoin: json['totalPoin'],
      jumlahPengumpulan: json['jumlahPengumpulan'],
      available: json['available'],
      poinSaatIni: json['poinSaatIni'],
      userId: json['userId'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  User({
    required this.username,
    required this.role,
  });

  final String username;
  final String role;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      role: json['role'],
    );
  }
}
