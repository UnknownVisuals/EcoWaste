class DesaModel {
  DesaModel({
    required this.id,
    required this.nama,
    required this.kecamatan,
    required this.kabupaten,
    required this.provinsi,
  });

  final String id, nama, kecamatan, kabupaten, provinsi;

  factory DesaModel.fromJson(Map<String, dynamic> json) {
    return DesaModel(
      id: json['id'],
      nama: json['nama'],
      kecamatan: json['kecamatan'],
      kabupaten: json['kabupaten'],
      provinsi: json['provinsi'],
    );
  }
}
