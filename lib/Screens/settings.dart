import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../widgets/custom_app_bar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color:
                      const Color.fromARGB(62, 22, 26, 137).withOpacity(0.03),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/current_user.jpg'), // Replace with the current user's image
                            radius: 30,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/phrase');
                            },
                            child: Row(
                                // children: [
                                //   Icon(Icons.edit, size: 20),
                                //   SizedBox(width: 5),
                                //   Text(
                                //     "Change",
                                //     style: TextStyle(
                                //       decoration: TextDecoration.underline,
                                //       fontWeight: FontWeight.w400,
                                //     ),
                                //   ),
                                // ],
                                ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Username",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            "Rhaenyra Targaryen",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/username');
                            },
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 20),
                                SizedBox(width: 5),
                                // Text(
                                //   "Edit",
                                //   style: TextStyle(
                                //     decoration: TextDecoration.underline,
                                //     fontWeight: FontWeight.w400,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Divider(
                      //   color: Colors.grey,
                      //   height: 30,
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Public Key",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                          "MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgH95JCEmG0wn6TTO6F3TxjrjCyrr/fvQUnBLv0n8qu1Ys6TfKdhjC1f4FWNsviLcgrtY9XWzZ9LjfZQ1DA1M1nEUzrGXcQDsK3YgGeyCKtpLpzz5z0n63oDUChS9UQqRFlpNZecda39Pg5OOqoiLVBKGqzRtVZsPpapYIbzpJ2zFAgMBAAE="),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: QrImageView(
                          data:
                              "MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgH95JCEmG0wn6TTO6F3TxjrjCyrr/fvQUnBLv0n8qu1Ys6TfKdhjC1f4FWNsviLcgrtY9XWzZ9LjfZQ1DA1M1nEUzrGXcQDsK3YgGeyCKtpLpzz5z0n63oDUChS9UQqRFlpNZecda39Pg5OOqoiLVBKGqzRtVZsPpapYIbzpJ2zFAgMBAAE=", // Replace with the actual ID
                          version: QrVersions.auto,
                          size: 150.0,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            'Log Out',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1A2247),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
