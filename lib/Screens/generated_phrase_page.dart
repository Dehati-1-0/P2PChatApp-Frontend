import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

// want id and the user name to be displayed.
class GeneratedPhrasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 150,
            ),
            SizedBox(height: 30),
            Text(
              'Your Key Phrase',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'I like dogs',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Kindly make sure that your key phrase is remembered or securely noted down.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 70),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/username');
              },
              child: Text(
                'Continue',
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
