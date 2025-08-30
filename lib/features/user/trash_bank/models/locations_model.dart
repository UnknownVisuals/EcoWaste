class LocationsModel {
  LocationsModel({
    required this.id,
    required this.desa,
    required this.kecamatan,
    required this.kabupaten,
  });

  final String id, desa, kecamatan, kabupaten;

  factory LocationsModel.fromJson(Map<String, dynamic> json) {
    return LocationsModel(
      id: json['id']?.toString() ?? '',
      desa: json['desa']?.toString() ?? '',
      kecamatan: json['kecamatan']?.toString() ?? '',
      kabupaten: json['kabupaten']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'desa': desa,
      'kecamatan': kecamatan,
      'kabupaten': kabupaten,
    };
  }
}
