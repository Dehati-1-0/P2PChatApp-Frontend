import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'user_profile_page.dart'; // Import the user profile page
import '../services/message_sender.dart'; // Import the MessageSender class
import '../models/message.dart';

class ChatPage extends StatefulWidget {
  final String userName;
  final String userAvatar;
  final bool isOnline;
  final String deviceIp;

  ChatPage({
    required this.userName,
    required this.userAvatar,
    this.isOnline = false,
    required this.deviceIp,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  static const platform = MethodChannel('com.example.p2pchat/receiveMessage');
  final List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _startServer();
    _setupMessageListener();
  }

  void _navigateToUserProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfilePage(
          userName: widget.userName,
          userAvatar: widget.userAvatar,
        ),
      ),
    );
  }

  void _sendMessage() {
    String message = _messageController.text;
    if (message.isNotEmpty) {
      MessageSender.sendMessage(message, widget.deviceIp, 12345).then((result) {
        if (result['success']) {
          setState(() {
            _messages.add(Message(
              sender: 'Me',
              content: message,
              timestamp: DateTime.now(),
            ));
          });
        } else {
          print("Failed to send message to ${result['serverIp']}:${result['serverPort']}");
        }
      });
      _messageController.clear();
    }
  }

  void _startServer() async {
    try {
      await platform.invokeMethod('startServer', {'port': 12345});
    } on PlatformException catch (e) {
      print("Failed to start server: '${e.message}'.");
    }
  }

  void _setupMessageListener() {
    platform.setMethodCallHandler((call) async {
      if (call.method == 'onMessageReceived') {
        final dynamic message = call.arguments;
        if (message is String) {
          setState(() {
            _messages.add(Message(
              sender: widget.userName,
              content: message,
              timestamp: DateTime.now(),
            ));
          });
        } else if (message is Map<dynamic, dynamic>) {
          // Handle the case where the message is a Map
          print("Received message is a Map: $message");
        } else {
          print("Received message is of unknown type: $message");
        }
      }
    });
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
                backgroundImage: AssetImage(widget.userAvatar),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.userName, style: TextStyle(color: Colors.black)),
                  Text(widget.isOnline ? 'Online' : 'Offline',
                      style: TextStyle(
                          color: widget.isOnline ? Colors.green : Colors.red,
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
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                if (message.sender == 'Me') {
                  return _buildSentMessage(context, message.content);
                } else {
                  return _buildReceivedMessage(context, message.content, widget.userAvatar);
                }
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(BuildContext context, String message, String avatarPath) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
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

  Widget _buildSentMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
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
                controller: _messageController,
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
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}