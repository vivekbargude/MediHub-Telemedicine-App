import 'package:flutter/material.dart';
import 'package:medihub/features/chat/services/chatData.dart';
import 'package:provider/provider.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatData = Provider.of<ChatData>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_active_outlined),
            onPressed: () {
              // Handle notification icon tap
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: chatData.fetchChatData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: chatData.chatMessages.length,
              itemBuilder: (context, index) {
                final message = chatData.chatMessages[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(message.image),
                  ),
                  title: Text(message.name),
                  subtitle: Text(message.message),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (message.unreadCount > 0)
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Text(
                            '${message.unreadCount}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      Text(message.time),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
