class ConfirmationModel {
  ConfirmationModel({
    required this.id,
    required this.value,
  });

  final String id;
  final bool value;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'available': value,
    };
  }
}
