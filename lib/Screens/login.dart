import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _privateKeyController = TextEditingController();
  static const platform = MethodChannel('com.example.dehati/keys');

  Future<void> _handleLogin() async {
    final privateKey = _privateKeyController.text.trim();

    if (privateKey.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your private key')),
      );
      return;
    }

    try {
      // Generate the public key from the private key using the Kotlin method
      final publicKey = await platform.invokeMethod<String>(
        'generatePublicKey',
        {'privateKey': privateKey},
      );

      if (publicKey != null) {
        // Store the private and public keys in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('privateKey', privateKey);
        await prefs.setString('publicKey', publicKey);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!')),
        );

        // Navigate to the next screen
        Navigator.pushNamed(context, '/existinguser');
      } else {
        throw Exception("Public key generation failed.");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50),
            Image.asset('assets/dehati_logo.png', height: 100),
            SizedBox(height: 20),
            Text(
              "Enter your Private Key",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 30),
            TextField(
              controller: _privateKeyController,
              decoration: InputDecoration(
                hintText: 'Type here',
                border: OutlineInputBorder(),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _handleLogin,
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1A2247),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/scan');
                },
                child: Text(
                  "Scan QR Code",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A2247)),
                ),
              ),
            ),
            SizedBox(height: 40),
            Divider(color: Color.fromARGB(61, 135, 136, 144).withOpacity(0.3)),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Are You New Here?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Tap below to create your unique identity and get started!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/keyphrase');
              },
              child: Text(
                'Generate unique identity',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1A2247),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
