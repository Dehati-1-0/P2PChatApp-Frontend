import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class KeyPhrasePage extends StatelessWidget {
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
              "Why We Need Your ID & Key Phrase?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: const Color.fromARGB(62, 22, 26, 137).withOpacity(0.03),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text:
                              "Before using Dehati App, we ask for your unique ID, key phrase, and username to ensure a secure and personalized experience:\n\n",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "Unique ID:\n",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              "This serves as your digital identity, helping others find you while keeping your personal details private.\n\n",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "Key Phrase:\n",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              "A unique phrase for security, allowing you to recover your ID when changing or logging into a new device. This maintains your identity without recovering old contacts.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/generatedphrase');
                },
                child: Text(
                  'Generate',
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
