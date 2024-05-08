class ChatMessage {
  final String name;
  final String message;
  final String time;
  final int unreadCount;
  final String image;

  ChatMessage({
    required this.name,
    required this.message,
    required this.time,
    required this.unreadCount,
    required this.image,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      name: json['name'],
      message: json['message'],
      time: json['time'],
      unreadCount: json['unreadCount'],
      image: json['image'],
    );
  }
}
