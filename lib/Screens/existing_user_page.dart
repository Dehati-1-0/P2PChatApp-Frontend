import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeBackPage extends StatefulWidget {
  @override
  _WelcomeBackPageState createState() => _WelcomeBackPageState();
}

class _WelcomeBackPageState extends State<WelcomeBackPage> {
  static const keyChannel = MethodChannel('com.example.dehati/keys');
  String publicKey = '';
  String privateKey = '';
  String username = '';

  @override
  void initState() {
    super.initState();
    fetchKeys();
  }

  Future<void> fetchKeys() async {
    final prefs = await SharedPreferences.getInstance();
    final storedPublicKey = prefs.getString('publicKey');
    final storedPrivateKey = prefs.getString('privateKey');
    final storedUsername = prefs.getString('username');
    final isQrGenerated = prefs.getBool('isQrGenerated') ?? false;

    if (storedPublicKey != null && storedPrivateKey != null && isQrGenerated) {
      setState(() {
        publicKey = storedPublicKey;
        privateKey = storedPrivateKey;
        username = storedUsername ?? 'Unknown User';
      });
      print('Existing Public Key: $publicKey');
      print('Existing Private Key: $privateKey');
      print('Existing Username: $username');
    } else {
      generateKeyPair();
    }
  }

  Future<void> generateKeyPair() async {
    try {
      final result = await keyChannel.invokeMethod('generateKeyPair');
      setState(() {
        publicKey = result['publicKey'];
        privateKey = result['privateKey'];
      });

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('publicKey', publicKey);
      prefs.setString('privateKey', privateKey);
      prefs.setBool('isQrGenerated', true);

      print('Generated Public Key: $publicKey');
      print('Generated Private Key: $privateKey');
    } on PlatformException catch (e) {
      print("Failed to generate key pair: '${e.message}'.");
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
            SizedBox(height: 10),
            Text(
              'This is your username: $username',
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
            Center(
              child: publicKey.isNotEmpty
                  ? QrImageView(
                      data: publicKey,
                      version: QrVersions.auto,
                      size: 200.0,
                    )
                  : CircularProgressIndicator(),
            ),
            SizedBox(height: 20),
            Text(
              'Your Private Key',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: privateKey.isNotEmpty
                  ? SelectableText(
                      privateKey,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    )
                  : CircularProgressIndicator(),
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}