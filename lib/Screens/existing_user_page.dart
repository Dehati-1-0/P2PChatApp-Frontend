import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class WelcomeBackPage extends StatefulWidget {
  @override
  _WelcomeBackPageState createState() => _WelcomeBackPageState();
}

class _WelcomeBackPageState extends State<WelcomeBackPage> {
  String publicKey = '';
  String privateKey = '';
  String username = '';
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    fetchKeys();
  }

  Future<void> fetchKeys() async {
    final prefs = await SharedPreferences.getInstance();
    final storedPublicKey = prefs.getString('publicKey');
    final storedUsername = prefs.getString('username');
    final isQrGenerated = prefs.getBool('isQrGenerated') ?? false;

    if (storedPublicKey != null && isQrGenerated) {
      setState(() {
        publicKey = storedPublicKey;
        username = storedUsername ?? 'Unknown User';
      });
      print('Existing Public Key: $publicKey');
      print('Existing Username: $username');
    } else {
      // Redirect to login page with a message
      Navigator.pushNamed(context, '/login', arguments: {'loginFailed': true});
    }
  }

  Future<void> downloadQrCode() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/qr_code.png';
    screenshotController.captureAndSave(directory.path,
        fileName: 'qr_code.png');
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('QR Code saved to $imagePath')));
  }

  void copyPublicKeyToClipboard() {
    Clipboard.setData(ClipboardData(text: publicKey));
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Public Key copied to clipboard')));
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
            Navigator.pushNamed(context, '/login');
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
              'WELCOME  BACK',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32, // Reduced font size
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A174E),
              ),
            ),
            SizedBox(height: 10), // Reduced spacing
            Image.asset(
              'assets/logo.png',
              height: 80, // Reduced image height
            ),
            SizedBox(height: 10),
            Text(
              'This is your username: $username',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10), // Reduced spacing
            Text(
              'Your Public Key',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: publicKey.isNotEmpty
                  ? Screenshot(
                      controller: screenshotController,
                      child: QrImageView(
                        data: publicKey,
                        version: QrVersions.auto,
                        size: 150.0, // Reduced QR code size
                      ),
                    )
                  : CircularProgressIndicator(),
            ),
            SizedBox(height: 10), // Reduced spacing
            Text(
              'Your Public Key',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: publicKey.isNotEmpty
                  ? Expanded(
                      child: Container(
                        height: 80, // Reduced container height
                        child: SingleChildScrollView(
                          child: SelectableText(
                            publicKey,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  : CircularProgressIndicator(),
            ),
            SizedBox(height: 10), // Reduced spacing
            ElevatedButton(
              onPressed: downloadQrCode,
              child: Text(
                'Download QR Code',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1A2247),
                padding: EdgeInsets.symmetric(vertical: 12), // Reduced padding
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: copyPublicKeyToClipboard,
              child: Text(
                'Copy Public Key',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1A2247),
                padding: EdgeInsets.symmetric(vertical: 12), // Reduced padding
              ),
            ),
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
                padding: EdgeInsets.symmetric(vertical: 12), // Reduced padding
              ),
            ),
            SizedBox(height: 10), // Reduced spacing
          ],
        ),
      ),
    );
  }
}
