import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'messages_list.dart';
import 'welcome_page.dart';
import '../services/auth_services.dart'; // Import the AuthService
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final AuthService _authService = AuthService(); // Create an instance of AuthService
  static const platform = MethodChannel('com.example.dehati/broadcast');

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward().then((value) async {
      bool loggedIn = await _authService.isLoggedIn(); // Use the AuthService to check login status
      Future.delayed(Duration(seconds: 1), () {
        if (loggedIn) {
          Navigator.pushReplacementNamed(context, '/messages');
        } else {
          Navigator.pushReplacementNamed(context, '/welcome');
        }
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset(
                'assets/logo.png',
                height: 500,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/agreement');
                },
                child: Text(
                  'DEHATI',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A174E),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Discardable (Decentralized) Encrypted Host-based Application Level Tunneling Infrastructure\n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}