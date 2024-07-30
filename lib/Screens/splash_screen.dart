import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2), // Duration of the animation
      vsync: this,
    );

    _scaleAnimation =
        Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward().then((value) {
      // Navigate to the next screen after 2 seconds
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/welcome');
      });
    });
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
                'assets/logo.png', // Make sure the path is correct
                height: 500, // Adjust the height as needed
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
