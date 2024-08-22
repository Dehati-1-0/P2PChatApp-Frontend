import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_app_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static const keyChannel = MethodChannel('com.example.dehati/keys');
  String publicKey = '';
  String privateKey = '';
  String username = '';

  @override
  void initState() {
    super.initState();
    fetchKeys();
  }

  Future<void> fetchKeys() async {
    final prefs = await SharedPreferences.getInstance();
    final storedPublicKey = prefs.getString('publicKey');
    final storedPrivateKey = prefs.getString('privateKey');
    final storedUsername = prefs.getString('username');
    final isQrGenerated = prefs.getBool('isQrGenerated') ?? false;

    if (storedPublicKey != null && storedPrivateKey != null && isQrGenerated) {
      setState(() {
        publicKey = storedPublicKey;
        privateKey = storedPrivateKey;
        username = storedUsername ?? 'Unknown User';
      });
      print('Public Key: $publicKey');
      print('QR Code generated.');
    } else {
      generateKeyPair();
    }
  }

  Future<void> generateKeyPair() async {
    try {
      final result = await keyChannel.invokeMethod('generateKeyPair');
      setState(() {
        publicKey = result['publicKey'];
        privateKey = result['privateKey'];
      });

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('publicKey', publicKey);
      prefs.setString('privateKey', privateKey);
      prefs.setBool('isQrGenerated', true);

      print('Public Key: $publicKey');
      print('QR Code generated.');
    } on PlatformException catch (e) {
      print("Failed to generate key pair: '${e.message}'.");
    }
  }

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
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(62, 22, 26, 137).withOpacity(0.03),
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
                            backgroundImage: AssetImage('assets/current_user.jpg'),
                            radius: 30,
                          ),
                          SizedBox(width: 30),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/phrase');
                            },
                            child: Row(),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Username",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            username,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(width: 80),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/username');
                            },
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 20),
                                SizedBox(width: 5),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Public Key",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Text(publicKey),
                      SizedBox(height: 20),
                      Center(
                        child: publicKey.isNotEmpty
                            ? QrImageView(
                                data: publicKey,
                                version: QrVersions.auto,
                                size: 150.0,
                              )
                            : CircularProgressIndicator(),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Private Key",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: TextEditingController(text: privateKey),
                        maxLines: null,
                        readOnly: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 50),
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