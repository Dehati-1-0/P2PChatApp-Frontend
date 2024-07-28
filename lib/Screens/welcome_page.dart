import 'package:flutter/material.dart';

class WelcomeUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Spacer(),
            SizedBox(height: 50),
            Text(
              'Welcome to Dehati',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // SizedBox(height: 100),
            Spacer(),
            Image.asset(
              'assets/logo.png', // Replace with your image asset
              height: 200,
            ),
            Spacer(),
            Text(
              'Tap "Agree and Continue" to accept the Dehati Terms of Service and Privacy Policy.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, '/agreement'); // Replace with your route
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1A2247), // Button color
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'AGREE  AND  CONTINUE',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
