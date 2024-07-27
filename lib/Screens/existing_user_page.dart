import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WelcomeBackPage extends StatelessWidget {
  final String userId = 'Psd5588'; // Replace with the actual user ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(height: 30),
            Text(
              'WELCOME  BACK',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A174E),
              ),
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/dehati_logo.png',
              height: 100,
            ),
            SizedBox(height: 20),
            Text(
              'This is your id $userId',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black, 
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Your QR Code',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: QrImageView(
                data: '1234567',
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
            SizedBox(height: 20),
            Spacer(),
            Center(
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
