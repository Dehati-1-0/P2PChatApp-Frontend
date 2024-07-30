import 'package:Dehati/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
  const DiscoverPage({super.key});
}

class _DiscoverPageState extends State<DiscoverPage> {
  bool _isChatsSelected = true;
  int _selectedIndex = 0;
  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isChatsSelected = index == 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Align(alignment: Alignment.centerLeft, child: Text('Discover')),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushNamed(context, '/messages');
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/discover icons/background.png'),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text("Username"),
                        Text("ID"),
                        CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/discover icons/cat.png'), // Replace with the current user's image
                          radius: 30,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text("Username"),
                        Text("ID"),
                        CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/discover icons/rabbit.png'), // Replace with the current user's image
                          radius: 30,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text("Username"),
                        Text("ID"),
                        CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/discover icons/gorilla.png'), // Replace with the current user's image
                          radius: 30,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Username"),
                        Text("ID"),
                        CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/discover icons/panda.png'), // Replace with the current user's image
                          radius: 30,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Text("Username"),
                        Text("ID"),
                        CircleAvatar(
                          backgroundImage: AssetImage(
                              'assets/discover icons/meerkat.png'), // Replace with the current user's image
                          radius: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
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
}
