import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class DescriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(50.0),
        child: Column(
          children: [
            const Text(
              "Why ID & USERNAME ?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 30,
            ),
            // Container(
            //   decoration: BoxDecoration(
            //       color:
            //           const Color.fromARGB(62, 22, 26, 137).withOpacity(0.03),
            //       borderRadius: BorderRadius.circular(10)),
            //   child: const Padding(
            //     padding: EdgeInsets.all(10.0),
            //     child: Text(
            //       "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
            //       style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
            //     ),
            //   ),
            // ),
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: const Color.fromARGB(62, 22, 26, 137).withOpacity(0.03),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      'Before you begin using Dehati App, we ask for a few key details to ensure a secure and personalized experience:\n\n'
                      'Unique ID: Your unique ID serves as your digital identity within our system. It helps others find and connect with you while keeping your personal information private. This ID is unique to you and distinguishes you from other users.\n\n'
                      'Username: Your username is the name others will see on Dehati App. It adds a personal touch to your profile and makes it easy for friends and contacts to identify and remember you. You can choose a username that best represents you or use an alias if you prefer.\n\n'
                      'These elements—your unique ID and username—are designed to work together to provide a secure, private, and user-friendly experience on Dehati App. They help protect your identity, facilitate easy recognition by others, and ensure a seamless experience across devices.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/generatedid');
                },
                child: Text(
                  'Ok, I Understand',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1A2247),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
