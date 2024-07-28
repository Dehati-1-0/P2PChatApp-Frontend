import 'package:flutter/material.dart';
import 'chat_page.dart';

class MessagesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Discovery',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/current_user.jpg'), // Replace with the current user's image
                  radius: 20,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/contacts');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Chats',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/contacts');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Groups',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildMessageItem(
                      context,
                      'John Smith',
                      'Not too bad. I\'ve been working on...',
                      '1h ago',
                      'assets/user1.png',
                      true),
                  Divider(color: Colors.grey, thickness: 0.5),
                  _buildMessageItem(
                      context,
                      'Caren Simons',
                      'Not too bad. I\'ve been working on...',
                      '2h ago',
                      'assets/user2.png',
                      false),
                  Divider(color: Colors.grey, thickness: 0.5),
                  _buildMessageItem(
                      context,
                      'Brews Wain',
                      'Not too bad. I\'ve been working on...',
                      '3h ago',
                      'assets/user3.png',
                      false),
                  Divider(color: Colors.grey, thickness: 0.5),
                  _buildMessageItem(
                      context,
                      'Jhone Wilson',
                      'Not too bad. I\'ve been working on...',
                      'Yesterday',
                      'assets/user4.png',
                      true),
                  Divider(color: Colors.grey, thickness: 0.5),
                  _buildMessageItem(
                      context,
                      'Benjamin Tenison',
                      'Not too bad. I\'ve been working on...',
                      'Wednesday',
                      'assets/user5.png',
                      false),
                  Divider(color: Colors.grey, thickness: 0.5),
                  _buildMessageItem(
                      context,
                      'Jhone Wilson',
                      'Not too bad. I\'ve been working on...',
                      'Friday',
                      'assets/user4.png',
                      false),
                  Divider(color: Colors.grey, thickness: 0.5),
                  _buildMessageItem(
                      context,
                      'Peter Parker',
                      'Not too bad. I\'ve been working on...',
                      'Friday',
                      'assets/user6.png',
                      false),
                ],
              ),
            ),
            Container(
              color: Colors.blue,
              padding: EdgeInsets.symmetric(vertical: 10),
              // height: 60.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.compass_calibration_outlined,
                        color: Colors.black),
                    onPressed: () {
                      Navigator.pushNamed(context, '/discover');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.chat_bubble_outline, color: Colors.black),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/contacts');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.people_outline, color: Colors.black),
                    onPressed: () {
                      Navigator.pushNamed(context, '/contacts');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMessageItem(BuildContext context, String name, String message,
      String time, String avatarPath, bool isNew) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(avatarPath),
      ),
      title: Text(name),
      subtitle: Text(message),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time),
          if (isNew) Icon(Icons.circle, color: Colors.blue, size: 10),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              userName: name,
              userAvatar: avatarPath,
              isOnline: isNew,
            ),
          ),
        );
      },
    );
  }
}
