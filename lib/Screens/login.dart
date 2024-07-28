import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 10, 40, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 80,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "Enter Your phrase here",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(
                  color: Color.fromARGB(61, 135, 136, 144).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    hintText: 'Enter Your phrase here',
                    border: InputBorder.none,
                    filled: true,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),

//button

            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/existinguser');
              },
              child: Center(
                child: Container(
                  height: 70,
                  width: 338,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF1A2247),
                  ),
                  child: const Center(
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
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
              "Don't have a phrase?",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 30,
            ),
            //button

            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/keyphrase');
              },
              child: Center(
                child: Container(
                  height: 70,
                  width: 338,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF1A2247),
                  ),
                  child: const Center(
                    child: const Text(
                      "Generate a unique key phrase",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "centuries, but also the leap into electronic typesetting, remaining",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
