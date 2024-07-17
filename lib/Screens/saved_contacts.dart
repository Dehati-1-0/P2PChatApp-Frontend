import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class SavedContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Contacts'),
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
                  _buildContactItem('Jhon Smith', 'assets/user1.png'),
                  _buildContactItem('Caren Simons', 'assets/user2.png'),
                  _buildContactItem('Peter Parker', 'assets/user3.png'),
                  _buildContactItem('Tony Stark', 'assets/user4.png'),
                  _buildContactItem('Brews Wain', 'assets/user5.png'),
                  _buildContactItem('Benjamin Tenison', 'assets/user6.png'),
                  _buildContactItem('Maxwell Woods', 'assets/user7.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(String name, String avatarPath) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(avatarPath),
      ),
      title: Text(name),
      onTap: () {
        // Handle contact item tap
      },
    );
  }
}
