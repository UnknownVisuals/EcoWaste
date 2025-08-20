class SignupModel {
  SignupModel({
    required this.name,
    required this.email,
    required this.password,
    this.role = 'USER',
    this.tps3rId,
  });

  final String name, email, password, role;
  final String? tps3rId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    };

    if (tps3rId != null) {
      data['tps3rId'] = tps3rId;
    }

    return data;
  }
}
