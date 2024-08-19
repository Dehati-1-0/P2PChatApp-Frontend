import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async'; // Import the dart:async library
import '../models/discovered_device.dart'; // Import the model
import 'empty_chats_page.dart'; // Import the ChatPage
import 'chat_page.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
  const DiscoverPage({super.key});
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  static const EventChannel _eventChannel =
      EventChannel('com.example.p2pchat/discoveredDevices');
  final List<DiscoveredDevice> _devices = [];
  late StreamSubscription _subscription;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isChatsSelected = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller
      ..repeat(reverse: true); // Repeat the animation forward and backward

    _subscription = _eventChannel.receiveBroadcastStream().listen(
      (dynamic event) {
        setState(() {
          _devices
              .add(DiscoveredDevice.fromJson(Map<String, dynamic>.from(event)));
        });
      },
      onError: (dynamic error) {
        print('Received error: ${error.message}');
      },
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onBottomNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _isChatsSelected = index == 0;
    });
  }

  void _navigateToEmptyChatPage(
      BuildContext context, String username, String avatarPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmptyChatsPage(
          username: username,
          avatarPath: avatarPath,
        ),
      ),
    );
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
                        image: AssetImage('assets/discover_background.png'),
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
                  children: _devices
                      .map((device) => DeviceWidget(device: device))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF1A2247),
        child: SizedBox(
          height: 56,
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

class DeviceWidget extends StatelessWidget {
  final DiscoveredDevice device;

  const DeviceWidget({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(device.modelName),
        Text(device.ip),
        GestureDetector(
          onTap: () {
            // Navigate to the empty chat page
            // Navigator.pushNamed(context, '/messages');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  userName: device.modelName,
                  userAvatar: 'assets/discover icons/cat.png', // Replace with dynamic image if needed
                  isOnline: true, // Set this based on your logic
                ),
              ),
            );
          },
          child: CircleAvatar(
            backgroundImage: AssetImage(
                'assets/discover icons/cat.png'), // Replace with dynamic images if needed
            radius: 30,
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
