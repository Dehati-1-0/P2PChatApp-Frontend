import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';
import 'agreement_page.dart';

class WelcomeUserPage extends StatelessWidget {
  void _navigateToAgreementPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AgreementPage()),
    );
  }

  void _launchURL() async {
    const url = 'https://example.com/privacy';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text(
              'Welcome to Dehati',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Spacer(),
            Image.asset(
              'assets/logo.png', // Replace with your image asset
              height: 200,
            ),
            Spacer(),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.black54),
                children: [
                  TextSpan(text: 'Tap "Agree and Continue" to accept the '),
                  TextSpan(
                    text: 'Dehati Terms of Service & Privacy Policy',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _navigateToAgreementPage(context);
                      },
                  ),
                  TextSpan(text: '.'),
                ],
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, '/login'); // Replace with your route
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1A2247), // Button color
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'AGREE  AND  CONTINUE',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
