import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class UserId extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SizedBox(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/dehati_logo.png', height: 100),
                      SizedBox(height: 20),
                      Text(
                        'User id & Phrase',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'User id',
                  border: OutlineInputBorder(),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phrase',
                  border: OutlineInputBorder(),
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
              SizedBox(height: 80),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),

              SizedBox(
                height: 80,
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/regenerate');
                },
                child: Text(
                  'Generate New Keys',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0A174E),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              SizedBox(height: 50),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, '/messages');
              //   },
              //   child: Text('Go to Messages'),
              //   style: ElevatedButton.styleFrom(
              //     iconColor: Color(0xFF0A174E),
              //     padding: EdgeInsets.symmetric(vertical: 16),
              //   ),
              // ),
              // Spacer(),
              Center(
                child: Text(
                  'centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
