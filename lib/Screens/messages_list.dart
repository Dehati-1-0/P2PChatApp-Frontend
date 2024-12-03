import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Add this for Provider usage
import 'chat_page.dart';
import '../services/database_service.dart';

class MessagesList extends StatefulWidget {
  final String currentUser; // Pass the logged-in user's username

  const MessagesList({Key? key, required this.currentUser}) : super(key: key);

  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final dbService;  // Removed the incorrect initialization here
  List<Map<String, String>> _conversations = [];

  _MessagesListState() : dbService = DatabaseService(currentUser: 'YourCurrentUser');  // Correct initialization

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    final conversations = await dbService.getConversations(widget.currentUser);
    setState(() {
      _conversations = conversations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chats', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushNamed(context, '/existinguser');
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/current_user.jpg'),
              radius: 20,
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _conversations.isEmpty
                  ? Center(child: Text("No conversations yet"))
                  : ListView(
                      children: _buildChatItems(context),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF1A2247),
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.compass_calibration_outlined),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/discover');
                },
              ),
              IconButton(
                icon: Icon(Icons.chat_bubble_outline),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/messages');
                },
              ),
              IconButton(
                icon: Icon(Icons.people_outline),
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, '/contacts');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChatItems(BuildContext context) {
    return _conversations.map((conversation) {
      return Column(
        children: [
          _buildMessageItem(
            context,
            conversation['username'] ?? 'Unknown User',
            conversation['modelName'] ?? 'Unknown Model',
          ),
          Divider(),
        ],
      );
    }).toList();
  }

  Widget _buildMessageItem(BuildContext context, String username, String modelName) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/default_avatar.png'), // Default avatar
      ),
      title: Text(username),
      subtitle: Text(modelName),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              userName: username,
              userAvatar: 'assets/default_avatar.png',
              isOnline: true, // Placeholder
              deviceIp: '', // Add logic if needed
            ),
          ),
        );
      },
    );
  }
}
