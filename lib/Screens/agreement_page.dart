import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/custom_app_bar.dart';

class AgreementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/dehati_logo.png',
              height: 250,
              width: 300,
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'Last Updated: 20/07/2024.\n'
                  'By using our services, you agree to be bound by our Terms and Conditions and Privacy Policy. You are responsible for your account and all activities under it. We prioritize your privacy with end-to-end encryption, though no system is 100% secure. Do not use Dehati App for unlawful purposes. All content is owned by us or our licensors, and you may use the app for personal, non-commercial purposes only. We may terminate your access without notice for violations. The app is provided "as is," and we are not liable for indirect or consequential damages. Continued use signifies acceptance of any updates to these terms.\n'
                  'For the full Terms and Conditions, please visit the link below.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                'AGREE',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1A2247),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: InkWell(
                onTap: () async {
                  const url = 'https://www.whatsapp.com/legal/privacy-policy';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                child: Text(
                  'Read full Terms and Conditions',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
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
