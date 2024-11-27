import 'package:Dehati/main.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';

class GeneratedIdPage extends StatefulWidget {
  @override
  _GeneratedIdPageState createState() => _GeneratedIdPageState();
}

class _GeneratedIdPageState extends State<GeneratedIdPage> {
  String userName = '';
  String publicKey = '';
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('username') ?? 'Unknown User';
      publicKey = prefs.getString('publicKey') ?? '';
    });
    print('Fetched Username: $userName');
    print('Fetched Public Key: $publicKey');
  }

  Future<void> _downloadQRCode() async {
    try {
      final Uint8List? image = await _screenshotController.capture();
      if (image != null) {
        final result = await ImageGallerySaver.saveImage(image, name: 'QRCode');
        if (result['isSuccess']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('QR Code saved to gallery!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save QR Code!')),
          );
        }
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving QR Code: $e')),
      );
    }
  }

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
              'This is your username: $userName',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Your Public Key',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Screenshot(
              controller: _screenshotController,
              child: Center(
                child: publicKey.isNotEmpty
                    ? QrImageView(
                        data: publicKey,
                        version: QrVersions.auto,
                        size: 200.0,
                      )
                    : CircularProgressIndicator(),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 80,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  publicKey,
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: publicKey));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Public Key copied to clipboard!'),
                  ),
                );
              },
              child: Text('Copy Public Key'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _downloadQRCode,
              child: Text('Download QR Code'),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/messages');
                MyApp().startBroadcast(12345);
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
