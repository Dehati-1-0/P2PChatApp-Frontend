import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math';
import '../models/discovered_device.dart';
import 'chat_page.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
  const DiscoverPage({super.key});
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  static const platform = MethodChannel('com.example.dehati/broadcast');
  static const EventChannel _eventChannel =
  EventChannel('com.example.p2pchat/discoveredDevices');
  final Map<String, DiscoveredDevice> _deviceMap = {};
  final List<DiscoveredDevice> _devices = [];
  final Map<String, String> _deviceAvatars = {};
  final List<String> _avatarPaths = [
    'assets/discover icons/cat.png',
    'assets/discover icons/dog.png',
    'assets/discover icons/fox.png',
    'assets/discover icons/panda.png',
  ];
  late StreamSubscription _subscription;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isChatsSelected = true;
  int _selectedIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startBroadcast(12345);
    _startListening();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller..repeat(reverse: true);

    _subscription = _eventChannel.receiveBroadcastStream().listen(
          (dynamic event) {
        setState(() {
          final device =
          DiscoveredDevice.fromJson(Map<String, dynamic>.from(event));
          _deviceMap[device.ip] = device;
          _deviceMap[device.ip]!.lastSeen = DateTime.now();

          if (!_deviceAvatars.containsKey(device.ip)) {
            final randomIndex = Random().nextInt(_avatarPaths.length);
            _deviceAvatars[device.ip] = _avatarPaths[randomIndex];
          }

          _updateDeviceList();
        });
      },
      onError: (dynamic error) {
        print('Received error: ${error.message}');
      },
    );

    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      setState(() {
        _removeStaleDevices();
        _updateDeviceList();
      });
    });
  }

  Future<void> _startBroadcast(int port) async {
    try {
      await platform.invokeMethod('broadcastIp', {'port': port});
    } on PlatformException catch (e) {
      print("Failed to start broadcast: '${e.message}'.");
    }
  }

  Future<void> _startListening() async {
    try {
      await platform.invokeMethod('listenForBroadcasts');
    } on PlatformException catch (e) {
      print("Failed to start listening: '${e.message}'.");
    }
  }

  void _removeStaleDevices() {
    final now = DateTime.now();
    _deviceMap.removeWhere(
            (ip, device) => now.difference(device.lastSeen).inSeconds > 15);
  }

  void _updateDeviceList() {
    _devices
      ..clear()
      ..addAll(_deviceMap.values);
    print("Devices: $_devices");
  }

  @override
  void dispose() {
    _subscription.cancel();
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

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
      body: Stack(
        children: [
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
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: _devices.isEmpty
                  ? Center(
                child: Text(
                  'No devices found',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
                  : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of items per row
                  crossAxisSpacing: 20.0, // Spacing between columns
                  mainAxisSpacing: 20.0, // Spacing between rows
                ),
                itemCount: _devices.length,
                itemBuilder: (context, index) {
                  final device = _devices[index];
                  final avatarPath = _deviceAvatars[device.ip]!;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            userName: device.modelName,
                            userAvatar: avatarPath,
                            isOnline: true,
                            deviceIp: device.ip,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(avatarPath),
                          radius: 20,
                        ),
                        SizedBox(height: 8),
                        Text(
                          device.modelName,
                          style: TextStyle(fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
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
                // IconButton(
                //   icon: Icon(
                //     Icons.people_outline,
                //     color: _selectedIndex == 2 ? Colors.black : Colors.white,
                //   ),
                //   onPressed: () {
                //     _onBottomNavItemTapped(2);
                //     Navigator.pushNamed(context, '/contacts');
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}