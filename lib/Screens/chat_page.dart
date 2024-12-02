import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'user_profile_page.dart'; // Import the user profile page
import '../services/message_sender.dart'; // Import the MessageSender class
import '../models/message.dart';
import '../services/database_service.dart';

class ChatPage extends StatefulWidget {
  final String userName; // Receiver's username
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
    _loadMessages(); // Load messages from the database on page load
  }

  // Method to navigate to the UserProfilePage
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

  // Load messages from the database
  Future<void> _loadMessages() async {
    final savedMessages = await DatabaseService().getMessages(
      'Me', // Current user as the senderUsername
      widget.userName, // Receiver's username
    );
    setState(() {
      _messages.addAll(savedMessages);
    });
  }

  // Method to send the message and clear the input field
  void _sendMessage() async {
    String messageContent = _messageController.text;
    if (messageContent.isNotEmpty) {
      MessageSender.sendMessage(messageContent, widget.deviceIp, 12345).then((result) async {
        if (result['success']) {
          final newMessage = Message(
            senderUsername: 'Me',
            senderIp: 'My Device IP',
            senderModelName: 'My Device Model',
            receiverUsername: widget.userName,
            receiverIp: widget.deviceIp,
            receiverModelName: 'Receiver Device Model', // Update with actual data
            content: messageContent,
            timestamp: DateTime.now(),
          );

          setState(() {
            _messages.add(newMessage);
          });

          // Save the sent message to the database
          await DatabaseService().saveMessage(newMessage);

          print("Message sent to ${result['serverIp']}:${result['serverPort']}");
        } else {
          print("Failed to send message to ${result['serverIp']}:${result['serverPort']}");
        }
      });

      _messageController.clear(); // Clear the input field after sending
    }
  }

  void _startServer() async {
    try {
      await platform.invokeMethod('startServer', {'port': 12345});
      print("Server started successfully.");
    } on PlatformException catch (e) {
      print("Failed to start server: '${e.message}'.");
    }
  }

  void _setupMessageListener() {
    platform.setMethodCallHandler((call) async {
      if (call.method == 'onMessageReceived') {
        final String messageContent = call.arguments;
        final newMessage = Message(
          senderUsername: widget.userName,
          senderIp: widget.deviceIp,
          senderModelName: 'Sender Device Model', // Update with actual data
          receiverUsername: 'Me',
          receiverIp: 'My Device IP',
          receiverModelName: 'My Device Model',
          content: messageContent,
          timestamp: DateTime.now(),
        );

        setState(() {
          _messages.add(newMessage);
        });

        // Save the received message to the database
        await DatabaseService().saveMessage(newMessage);
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
                  Text(
                    widget.isOnline ? 'Online' : 'Offline',
                    style: TextStyle(
                      color: widget.isOnline ? Colors.green : Colors.red,
                      fontSize: 12,
                    ),
                  ),
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
                if (message.senderUsername == 'Me') {
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
