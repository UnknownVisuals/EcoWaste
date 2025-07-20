class WasteTypeModel {
  WasteTypeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pricePerKg,
    required this.recyclable,
    required this.hazardous,
  });

  final String id, name, description;
  final double pricePerKg;
  final bool recyclable, hazardous;

  factory WasteTypeModel.fromJson(Map<String, dynamic> json) {
    return WasteTypeModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pricePerKg: double.parse(json['pricePerKg']),
      recyclable: json['recyclable'],
      hazardous: json['hazardous'],
    );
  }
}
