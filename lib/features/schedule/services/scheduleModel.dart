class Appointment {
  final String doctorName;
  final String doctorSpecialization;
  final String appointmentDate;
  final String appointmentTime;
  final String imageUrl;
  final bool isConfirmed;

  Appointment({
    required this.doctorName,
    required this.doctorSpecialization,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.imageUrl,
    required this.isConfirmed,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      doctorName: json['doctorName'],
      doctorSpecialization: json['doctorSpecialization'],
      appointmentDate: json['appointmentDate'],
      appointmentTime: json['appointmentTime'],
      imageUrl: json['imageUrl'],
      isConfirmed: json['isConfirmed'],
    );
  }
}
