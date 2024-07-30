import 'package:flutter/material.dart';
import 'chat_page.dart'; // Import the ChatPage

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
  const DiscoverPage({super.key});
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  bool _isChatsSelected = true;
  int _selectedIndex = 0;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller
      ..repeat(reverse: true); // Repeat the animation forward and backward
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isChatsSelected = index == 0;
    });
  }

  void _navigateToChatPage(
      BuildContext context, String name, String avatarPath, bool isOnline) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Stack(
        children: [
          // Animated background
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/discover icons/background.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Content
          Positioned.fill(
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
                            GestureDetector(
                              onTap: () {
                                _navigateToChatPage(context, 'John Smith',
                                    'assets/user1.png', true);
                              },
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/discover icons/cat.png'),
                                radius: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text("Username"),
                            Text("ID"),
                            GestureDetector(
                              onTap: () {
                                _navigateToChatPage(context, 'Caren Simons',
                                    'assets/user2.png', false);
                              },
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/discover icons/rabbit.png'),
                                radius: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("Username"),
                            Text("ID"),
                            GestureDetector(
                              onTap: () {
                                _navigateToChatPage(context, 'Peter Parker',
                                    'assets/user3.png', true);
                              },
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/discover icons/gorilla.png'),
                                radius: 30,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Username"),
                            Text("ID"),
                            GestureDetector(
                              onTap: () {
                                _navigateToChatPage(context, 'Tony Stark',
                                    'assets/user4.png', false);
                              },
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/discover icons/panda.png'),
                                radius: 30,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Text("Username"),
                            Text("ID"),
                            GestureDetector(
                              onTap: () {
                                _navigateToChatPage(context, 'Brews Wain',
                                    'assets/user5.png', true);
                              },
                              child: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/discover icons/meerkat.png'),
                                radius: 30,
                              ),
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
        ],
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
