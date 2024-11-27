import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';

class QRCodeGeneratePage extends StatefulWidget {
  @override
  _QRCodeGeneratePageState createState() => _QRCodeGeneratePageState();
}

class _QRCodeGeneratePageState extends State<QRCodeGeneratePage> {
  static const keyChannel = MethodChannel('com.example.dehati/keys');
  final ScreenshotController _screenshotController = ScreenshotController();
  String publicKey = '';
  String privateKey = '';
  String username = '';

  @override
  void initState() {
    super.initState();
    regenerateKeys();
  }

  Future<void> regenerateKeys() async {
    try {
      // Generate new key pair
      final result = await keyChannel.invokeMethod('generateKeyPair');
      setState(() {
        publicKey = result['publicKey'];
        privateKey = result['privateKey'];
      });

      // Store the new keys in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('publicKey', publicKey);
      prefs.setString('privateKey', privateKey);
      prefs.setBool('isQrGenerated', true);

      print('New Public Key: $publicKey');
      print('New Private Key: $privateKey');
      print('New QR Code generated for private key.');
    } on PlatformException catch (e) {
      print("Failed to generate key pair: '${e.message}'.");
    }
  }

  Future<void> _downloadQRCode() async {
    try {
      final Uint8List? image = await _screenshotController.capture();
      if (image != null) {
        final result = await ImageGallerySaver.saveImage(image, name: 'QRCode');
        if (result['isSuccess']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('QR Code saved to gallery!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save QR Code!')),
          );
        }
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving QR Code: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('QR Code'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Screenshot(
                controller: _screenshotController,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      privateKey.isNotEmpty
                          ? QrImageView(
                              data: privateKey,
                              size: 200,
                              version: QrVersions.auto,
                            )
                          : CircularProgressIndicator(),
                      SizedBox(height: 30),
                      Container(
                        height: 150,
                        child: TextField(
                          controller: TextEditingController(text: privateKey),
                          maxLines: null,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: 'Private Key',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: privateKey));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Private Key copied to clipboard!'),
                            ),
                          );
                        },
                        child: Text('Copy Private Key'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _downloadQRCode,
                        child: Text('Download QR Code'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/username');
                },
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1A2247),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
