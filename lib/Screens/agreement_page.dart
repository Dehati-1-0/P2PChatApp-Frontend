// screens/agreement_page.dart
import 'package:flutter/material.dart';

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
              height: 150,
              width: 200,
            ),
            SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the '
                  'industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type '
                  'and scrambled it to make a type specimen book. It has survived not only five centuries, but also the '
                  'leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text '
                  'of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text '
                  'ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type '
                  'specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, '
                  'remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting '
                  'industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an '
                  'unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived '
                  'not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. '
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the '
                  'industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type '
                  'and scrambled it to make a type specimen book. It has survived not only five centuries, but also the '
                  'leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text '
                  'of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text '
                  'ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type '
                  'specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, '
                  'remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting '
                  'industry.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
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
                backgroundColor: Color(0xFF0A174E),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
