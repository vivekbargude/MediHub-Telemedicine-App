class Appointment {
  final String id;
  final String doctorId;
  final String doctorName;
  final String doctorCategory;
  final String doctorImage;
  final String patientId;
  final String date;
  final String timeslot;
  final String status;
  final bool isConfirmed;

  Appointment({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.doctorCategory,
    required this.doctorImage,
    required this.patientId,
    required this.date,
    required this.timeslot,
    required this.status,
    required this.isConfirmed,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['_id'],
      doctorId: json['doctorId'],
      doctorName: json['doctorName'],
      doctorCategory: json['doctorCategory'],
      doctorImage: json['doctorImage'],
      patientId: json['patientId'],
      date: json['date'],
      timeslot: json['timeslot'],
      status: json['status'],
      isConfirmed: json['isConfirmed'],
    );
  }
}
