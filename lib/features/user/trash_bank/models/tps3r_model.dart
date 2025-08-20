class TPS3RModel {
  TPS3RModel({
    required this.id,
    required this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.contactPerson,
    this.phoneNumber,
    this.operationalHours,
    this.capacity,
    this.currentLoad,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  final String id, name;
  final String? address, contactPerson, phoneNumber, operationalHours;
  final double? latitude, longitude, capacity, currentLoad;
  final bool? isActive;
  final String? createdAt, updatedAt;

  factory TPS3RModel.fromJson(Map<String, dynamic> json) {
    return TPS3RModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      contactPerson: json['contactPerson'],
      phoneNumber: json['phoneNumber'],
      operationalHours: json['operationalHours'],
      capacity: json['capacity']?.toDouble(),
      currentLoad: json['currentLoad']?.toDouble(),
      isActive: json['isActive'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'contactPerson': contactPerson,
      'phoneNumber': phoneNumber,
      'operationalHours': operationalHours,
      'capacity': capacity,
      'currentLoad': currentLoad,
      'isActive': isActive,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Helper methods
  double get loadPercentage {
    if (capacity == null || currentLoad == null || capacity == 0) return 0.0;
    return (currentLoad! / capacity!) * 100;
  }

  bool get isNearCapacity => loadPercentage > 80;
  bool get isFull => loadPercentage >= 100;
}
