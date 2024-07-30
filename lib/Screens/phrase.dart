import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class PhrasePage extends StatelessWidget {
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
            Image.asset(
              'assets/dehati_logo.png',
              height: 150,
            ),
            SizedBox(height: 30),
            Text(
              'Enter your phrase here.',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                hintText: 'Type here',
                border: OutlineInputBorder(),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/existinguser');
              },
              child: Text(
                'SUBMIT',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0A174E),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
