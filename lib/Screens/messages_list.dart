import 'package:flutter/material.dart';
import 'chat_page.dart';

class MessagesList extends StatefulWidget {
  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  bool _isChatsSelected = true;
  int _selectedIndex = 1; // Default to the chats tab

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isChatsSelected = index == 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
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
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isChatsSelected = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _isChatsSelected
                            ? Color(0xFF1A2247)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Chats',
                        style: TextStyle(
                          color: _isChatsSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isChatsSelected = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !_isChatsSelected
                            ? Color(0xFF1A2247)
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Groups',
                        style: TextStyle(
                          color:
                              !_isChatsSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: _isChatsSelected
                    ? _buildChatItems(context)
                    : _buildGroupItems(context),
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
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF1A2247),
        child: SizedBox(
          height: 56, // Adjust the height as needed
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.compass_calibration_outlined,
                    color: _selectedIndex == 0 ? Colors.black : Colors.white,
                  ),
                  onPressed: () {
                    _onBottomNavItemTapped(0);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    color: _selectedIndex == 1 ? Colors.black : Colors.white,
                  ),
                  onPressed: () {
                    _onBottomNavItemTapped(1);
                    Navigator.pushNamed(context, '/messages');
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.people_outline,
                    color: _selectedIndex == 2 ? Colors.black : Colors.white,
                  ),
                  onPressed: () {
                    _onBottomNavItemTapped(2);
                    Navigator.pushNamed(context, '/contacts');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChatItems(BuildContext context) {
    return [
      _buildMessageItem(
        context,
        'John Smith',
        'Not too bad. I\'ve been working on...',
        '1h ago',
        'assets/user1.png',
        true,
      ),
      Divider(),
      _buildMessageItem(
        context,
        'Caren Simons',
        'Not too bad. I\'ve been working on...',
        '2h ago',
        'assets/user2.png',
        false,
      ),
      Divider(),
      _buildMessageItem(
        context,
        'Brews Wain',
        'Not too bad. I\'ve been working on...',
        '3h ago',
        'assets/user3.png',
        false,
      ),
      Divider(),
      _buildMessageItem(
        context,
        'Jhone Wilson',
        'Not too bad. I\'ve been working on...',
        'Yesterday',
        'assets/user4.png',
        true,
      ),
      Divider(),
      _buildMessageItem(
        context,
        'Benjamin Tenison',
        'Not too bad. I\'ve been working on...',
        'Wednesday',
        'assets/user5.png',
        false,
      ),
    ];
  }

  List<Widget> _buildGroupItems(BuildContext context) {
    return [
      _buildMessageItem(
        context,
        'Project Team',
        'Meeting at 3 PM...',
        '1h ago',
        'assets/group1.png',
        true,
      ),
      Divider(),
      _buildMessageItem(
        context,
        'Family',
        'Dinner at 8 PM...',
        '2h ago',
        'assets/group2.png',
        false,
      ),
      Divider(),
      _buildMessageItem(
        context,
        'Friends',
        'Movie night?',
        '3h ago',
        'assets/group3.png',
        false,
      ),
      Divider(),
      _buildMessageItem(
        context,
        'Work Group',
        'Deadline tomorrow...',
        'Yesterday',
        'assets/group4.png',
        true,
      ),
    ];
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
