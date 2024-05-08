class FreeTimeSlot {
  final String id;
  final String startTime;
  final String endTime;
  final bool isBooked;

  FreeTimeSlot({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
  });

  // Factory method to create a FreeTimeSlot instance from JSON
  factory FreeTimeSlot.fromJson(Map<String, dynamic> json) {
    return FreeTimeSlot(
      id: json['_id'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      isBooked: json['isBooked'],
    );
  }
}