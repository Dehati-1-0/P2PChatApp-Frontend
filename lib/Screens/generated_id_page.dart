import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GeneratedIdPage extends StatelessWidget {
  final String userId = 'Joh558812'; // Replace with the actual user ID
  final String userName = 'John Doe'; // Replace with the actual user name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Text(
              'WELCOME',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A174E),
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/logo.png',
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              'This is your id: $userId',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'This is your username: $userName',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Your QR Code',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: QrImageView(
                data: 'Joh558812',
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
            SizedBox(height: 20),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/messages');
              },
              child: Text(
                'Next',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1A2247),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            // Center(
            //   child: Text(
            //     'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(color: Colors.grey),
            //   ),
            // ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
