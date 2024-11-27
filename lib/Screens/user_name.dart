import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_app_bar.dart';

class UserName extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();

  Future<void> _saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
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