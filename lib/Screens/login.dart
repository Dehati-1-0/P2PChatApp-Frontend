import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset(
              'assets/logo.png', // Make sure the path is correct
              height: 100, // Adjust the height as needed
            ),
            SizedBox(height: 20),
            Text(
              'DEHATI',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            
            Spacer(),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 32.0),
               child: ElevatedButton(
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Color(0xFF0A174E), // Background color
                   padding: EdgeInsets.symmetric(vertical: 16.0),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(8.0),
                   ),
                 ),
                 onPressed: () {
                   Navigator.pushNamed(context, '/userid');
                 },
                 child: Center(
                   child: Text(
                     'LOGIN',
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 16,
                       fontWeight: FontWeight.bold,
                     ),

                   ),

                 ),
               ),
             ),
            SizedBox(height: 10),
            Text(
              'or',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            TextButton(
              onPressed: () {
                   Navigator.pushNamed(context, '/phrase');
              },
              child: Text(
                'Generate unique key phrase',
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: 16,
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
