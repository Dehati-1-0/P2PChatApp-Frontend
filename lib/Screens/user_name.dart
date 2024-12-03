import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_app_bar.dart';
import 'dart:math';

class UserName extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  Future<void> _saveUsername(String username) async {
    // Generate a unique alphanumeric suffix
    String uniqueSuffix = _generateRandomString(5);
    String uniqueUsername = '${username}_$uniqueSuffix';

    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', uniqueUsername);
    await sendUsernameToBackend(uniqueUsername);
    print('Saved Unique Username: $uniqueUsername');
  }

  Future<void> sendUsernameToBackend(String username) async {
    const platform = MethodChannel('com.example.dehati/broadcast');
    try {
      await platform.invokeMethod('setUsername', {'username': username});
      print('Username sent to backend: $username');
    } catch (e) {
      print('Failed to send username: $e');
    }
  }

  String _generateRandomString(int length) {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(
      Iterable.generate(length, (_) => characters.codeUnitAt(random.nextInt(characters.length))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/dehati_logo.png',
                height: 150,
              ),
              SizedBox(height: 30),
              Text(
                'Enter your username here',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'User Name',
                  border: OutlineInputBorder(),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  await _saveUsername(_usernameController.text);
                  Navigator.pushNamed(context, '/generatedid');
                },
                child: Text(
                  'Next',
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
      ),
    );
  }
}