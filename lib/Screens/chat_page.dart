import 'package:flutter/material.dart';
import 'user_profile_page.dart'; // Import the user profile page
import '../services/message_sender.dart'; // Import the MessageSender class

class ChatPage extends StatelessWidget {
  // Add a TextEditingController to manage the input field text
  final TextEditingController _messageController = TextEditingController();

  final String userName;
  final String userAvatar;
  final bool isOnline;

  ChatPage({
    required this.userName,
    required this.userAvatar,
    this.isOnline = false,
  });

  // Method to navigate to the UserProfilePage
  void _navigateToUserProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfilePage(
          userName: userName,
          userAvatar: userAvatar,
        ),
      ),
    );
  }

  // Method to send the message and clear the input field
  void _sendMessage() {
    String message = _messageController.text;
    if (message.isNotEmpty) {
      // Call your message sender backend method here
      MessageSender.sendMessage(message, "192.168.1.1", 12345);

      // Clear the input field after sending the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => _navigateToUserProfile(context),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(userAvatar),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userName, style: TextStyle(color: Colors.black)),
                  Text(isOnline ? 'Online' : 'Offline',
                      style: TextStyle(
                          color: isOnline ? Colors.green : Colors.red,
                          fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildReceivedMessage(
                    context, 'Hi, How\'s work been lately ?', userAvatar),
                _buildSentMessage(context,
                    'Hey ! it\'s been alright, just the usual grind. How about you ?'),
                _buildReceivedMessage(
                    context,
                    'Not too bad Nihara. I\'ve been working on a few Projects',
                    userAvatar),
                _buildSentMessage(
                    context, 'That sounds interesting. Anything exciting ?'),
                _buildReceivedMessage(context, 'Typing.........', userAvatar),
              ],
            ),
          ),
          _buildMessageInput(), // The input field and send button
        ],
      ),
    );
  }

  // Method to build received message bubbles
  Widget _buildReceivedMessage(
      BuildContext context, String message, String avatarPath) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
        BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => _navigateToUserProfile(context),
                child: CircleAvatar(
                  backgroundImage: AssetImage(avatarPath),
                  radius: 15,
                ),
              ),
              SizedBox(width: 10),
              Expanded(child: Text(message)),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build sent message bubbles
  Widget _buildSentMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
        BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF0A174E),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  // The input field and send button
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _messageController, // Attach the controller here
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF0A174E),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage, // Use the _sendMessage method here
            ),
          ),
        ],
      ),
    );
  }
}
