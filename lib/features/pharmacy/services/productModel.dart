class Pharmacy {
  final String id;
  final String medId;
  final String medName;
  final String medImage;
  final int medQuantity;
  final int medPrice;
  final String medDesc;

  Pharmacy({
    required this.id,
    required this.medId,
    required this.medName,
    required this.medImage,
    required this.medQuantity,
    required this.medPrice,
    required this.medDesc,
  });

 factory Pharmacy.fromMap(Map<String, dynamic> map) {
  return Pharmacy(
    id: map['_id'] ?? '',
    medId: map['medId'] ?? '',
    medName: map['medName'] ?? '',
    medImage: map['medImage'] ?? '',
    medQuantity: int.parse(map['medQuantity'] ?? '0'), // Convert String to int
    medPrice: int.parse(map['medPrice'] ?? '0'), // Convert String to int
    medDesc: map['medDesc'] ?? '',
  );
}

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medId': medId,
      'medName': medName,
      'medImage': medImage,
      'medQuantity': medQuantity,
      'medPrice': medPrice,
      'medDesc': medDesc,
    };
  }
}
