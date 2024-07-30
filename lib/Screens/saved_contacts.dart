import 'package:flutter/material.dart';
import 'chat_page.dart'; // Import the ChatPage

class SavedContacts extends StatefulWidget {
  @override
  _SavedContactsState createState() => _SavedContactsState();
}

class _SavedContactsState extends State<SavedContacts> {
  bool _isChatsSelected = true;
  int _selectedIndex = 2;

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isChatsSelected = index == 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Saved Contacts'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushNamed(context, '/messages');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Here',
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
              child: ListView(
                children: [
                  _buildContactItem(
                      context, 'John Smith', 'assets/user1.png', true),
                  _buildContactItem(
                      context, 'Caren Simons', 'assets/user2.png', false),
                  _buildContactItem(
                      context, 'Peter Parker', 'assets/user3.png', true),
                  _buildContactItem(
                      context, 'Tony Stark', 'assets/user4.png', false),
                  _buildContactItem(
                      context, 'Brews Wain', 'assets/user5.png', true),
                  _buildContactItem(
                      context, 'Benjamin Tenison', 'assets/user6.png', false),
                  _buildContactItem(
                      context, 'Maxwell Woods', 'assets/user7.png', true),
                ],
              ),
            ),
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
                    Navigator.pushNamed(context, '/discover');
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

  Widget _buildContactItem(
      BuildContext context, String name, String avatarPath, bool isOnline) {
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(avatarPath),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: isOnline ? Colors.green : Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        ],
      ),
      title: Text(name),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              userName: name,
              userAvatar: avatarPath,
              isOnline: isOnline,
            ),
          ),
        );
      },
    );
  }
}
