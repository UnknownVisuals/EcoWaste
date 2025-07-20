import 'package:eco_waste/features/user/trash_bank/models/desa_model.dart';

class ScheduleModel {
  ScheduleModel({
    required this.id,
    required this.desaId,
    required this.hari,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.desa,
  });

  final String id, desaId, hari;
  final DateTime waktuMulai, waktuSelesai;
  final DesaModel desa;

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'],
      desaId: json['desaId'],
      hari: json['hari'],
      waktuMulai: DateTime.parse(json['waktuMulai']).toLocal(),
      waktuSelesai: DateTime.parse(json['waktuSelesai']).toLocal(),
      desa: DesaModel.fromJson(json['desa']),
    );
  }
}
