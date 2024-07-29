import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50,
            ),
            Image.asset(
              'assets/dehati_logo.png',
              height: 100,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Enter your phrase here",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Type here',
                border: OutlineInputBorder(),
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
            SizedBox(
              height: 30,
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/existinguser');
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1A2247),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 1,
              width: 500,
              color: Color.fromARGB(61, 135, 136, 144).withOpacity(0.3),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              "Or",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(61, 135, 136, 144).withOpacity(0.3)),
            )),
            SizedBox(
              height: 30,
            ),
            Text(
              "Are You New Here?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Tap below to create your unique identity and get started!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 30,
            ),
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
            SizedBox(
              height: 30,
            ),
            // Text(
            //   "centuries, but also the leap into electronic typesetting, remaining",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
