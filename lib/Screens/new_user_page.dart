import 'package:flutter/material.dart';
import 'messages_list.dart'; // Replace with the actual page you want to navigate to

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next page after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MessagesList()), // Replace with the actual page
      );
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Spacer(),
  //           Image.asset(
  //             'assets/dehati_logo.png', // Make sure the path is correct
  //             height: 200, // Adjust the height as needed
  //           ),
  //           SizedBox(height: 20),
  //           Text(
  //             'Hello, welcome to Dehati',
  //             style: TextStyle(
  //               fontSize: 32,
  //               fontWeight: FontWeight.bold,
  //               color: Colors.black,
  //             ),
  //           ),
  //           Spacer(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(height: 30),
            Text(
              'Hello',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A174E),
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Welcome to ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 56,
                color: Colors.black,
              ),
            ),
            Image.asset(
              'assets/dehati_logo.png',
              height: 400,
            ),
            // SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
