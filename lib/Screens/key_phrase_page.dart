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
              "Why we need a unique key phrase?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(62, 22, 26, 137).withOpacity(0.03),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'The key phrase is crucial for maintaining the security and continuity of your identity on Dehati App. Generated uniquely for your device, it allows you to recover your original ID when switching devices or logging in from a different one, ensuring your identity remains recognizable. Unlike traditional recovery methods, the key phrase is a secure and simple way to verify your identity, making impersonation impossible. It does not restore saved contacts or messages, protecting your privacy and preventing unauthorized access. Remembering this key phrase simplifies account recovery and management, making it an essential part of securing your Dehati App account.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
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
