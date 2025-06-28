class LoginModel {
  LoginModel({
    required this.email,
    required this.password,
    required this.role,
  });

  final String email, password, role;

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'role': role,
    };
  }
}
