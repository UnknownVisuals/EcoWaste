class DepositAsusModel {
  DepositAsusModel({
    required this.username,
    required this.desaId,
    required this.berat,
    required this.jenisSampah,
    required this.poin,
    required this.waktu,
    required this.rt,
    required this.rw,
    required this.userId,
    required this.available,
    required this.wasteTypeId,
  });

  final String username, desaId, jenisSampah, rt, rw, userId, wasteTypeId;
  final double berat, poin;
  final DateTime waktu;
  final bool available;

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'desaId': desaId,
      'berat': berat,
      'jenisSampah': jenisSampah,
      'poin': poin,
      'waktu': waktu.toIso8601String(),
      'rt': rt,
      'rw': rw,
      'userId': userId,
      'available': available,
      'wasteTypeId': wasteTypeId,
    };
  }
}
