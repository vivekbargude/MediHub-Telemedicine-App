import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:medihub/features/chat/services/chatModel.dart';

class ChatData extends ChangeNotifier {
  List<ChatMessage> _chatMessages = [];
  List<ChatMessage> get chatMessages => _chatMessages;

  Future<void> fetchChatData() async {
    // Simulated delay to mimic network request
    await Future.delayed(Duration(seconds: 1));

    // Dummy data representing chat messages
    final List<Map<String, dynamic>> dummyData = [
      {
        'name': 'Alice',
        'message': 'Hey, how are you?',
        'time': '10:00 AM',
        'unreadCount': 3,
        'image': 'https://via.placeholder.com/150', // Sample image URL
      },
      {
        'name': 'Bob',
        'message': 'I\'m good, thanks!',
        'time': '10:05 AM',
        'unreadCount': 0,
        'image': 'https://via.placeholder.com/150', // Sample image URL
      },
      // Add more dummy chat messages here
    ];

    _chatMessages =
        dummyData.map((item) => ChatMessage.fromJson(item)).toList();
    notifyListeners();
  }
}
