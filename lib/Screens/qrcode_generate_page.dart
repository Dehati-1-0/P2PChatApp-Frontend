import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:typed_data';

class QRCodeGeneratePage extends StatefulWidget {
  @override
  _QRCodeGeneratePageState createState() => _QRCodeGeneratePageState();
}

class _QRCodeGeneratePageState extends State<QRCodeGeneratePage> {
  final TextEditingController _controller = TextEditingController(
    text:
        'MIICWwIBAAKBgH95JCEmG0wn6TTO6F3TxjrjCyrr/fvQUnBLv0n8qu1Ys6TfKdhjC1f4FWNsviLcgrtY9XWzZ9LjfZQ1DA1M1nEUzrGXcQDsK3YgGeyCKtpLpzz5z0n63oDUChS9UQqRFlpNZecda39Pg5OOqoiLVBKGqzRtVZsPpapYIbzpJ2zFAgMBAAECgYAq/thB2hGRAVE2f6d+pkSRbi1BH/I98kksGVB/Cxs4DRgivyblFpsn48SLEY2cQpZRzLKWLZoSVqrvx2i2P7mAVS2PfNqcfYW8xH1kijy24emGTNBs6N5qlEgH3g4ejnmjmxC1buN3Ww7YOV97S9XQPt9ffzXD9mIwQBtYcx74QJBANYVwFWjxT09s6k7deB5ZiynK9PkfSUeKaTDvTsvowKQAiptmqHwd9ebM++emfncKGyvvfxYjldJ1CLnly62Md0CQQCYbkhyPobmpIply+7tvkXBNj2pcmIWsb5Chu2HXYKPUE83JXNQViXnXO2Lyev3WxKM7XSkCLkM5M+Wws+2gZwJAkEAsS25S2dJ0wBg05uZWBlA3Y3RMQG2LOUEtA8nandnYrSKhlDFnGam2HLjjdnmNyrk7eaYxuMHkuhQQD8JGSjCpQJAOX5HRwf8e9wN821jFjsRNloOEe55vtOVzqPzzX3gs8t3xXYTs3Z633Q2iOZFYUvxiEQ8HW7I1WssPVIHZHAoeQJAAiuhI/xkH857FObZ/g7fka96pJSnA2g9PE0QKE8G+MTPTDgm8dg0sDPiLAqIViEcLJIVKV6PtI/d9y6rQ5uzpw==',
  );

  final ScreenshotController _screenshotController = ScreenshotController();

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
                      QrImageView(
                        data:
                            'MIICWwIBAAKBgH95JCEmG0wn6TTO6F3TxjrjCyrr/fvQUnBLv0n8qu1Ys6TfKdhjC1f4FWNsviLcgrtY9XWzZ9LjfZQ1DA1M1nEUzrGXcQDsK3YgGeyCKtpLpzz5z0n63oDUChS9UQqRFlpNZecda39Pg5OOqoiLVBKGqzRtVZsPpapYIbzpJ2zFAgMBAAECgYAq/thB2hGRAVE2f6d+pkSRbi1BH/I98kksGVB/Cxs4DRgivyblFpsn48SLEY2cQpZRzLKWLZoSVqrvx2i2P7mAVS2PfNqcfYW8xH1kijy24emGTNBs6N5qlEgH3g4ejnmjmxC1buN3Ww7YOV97S9XQPt9ffzXD9mIwQBtYcx74QJBANYVwFWjxT09s6k7deB5ZiynK9PkfSUeKaTDvTsvowKQAiptmqHwd9ebM++emfncKGyvvfxYjldJ1CLnly62Md0CQQCYbkhyPobmpIply+7tvkXBNj2pcmIWsb5Chu2HXYKPUE83JXNQViXnXO2Lyev3WxKM7XSkCLkM5M+Wws+2gZwJAkEAsS25S2dJ0wBg05uZWBlA3Y3RMQG2LOUEtA8nandnYrSKhlDFnGam2HLjjdnmNyrk7eaYxuMHkuhQQD8JGSjCpQJAOX5HRwf8e9wN821jFjsRNloOEe55vtOVzqPzzX3gs8t3xXYTs3Z633Q2iOZFYUvxiEQ8HW7I1WssPVIHZHAoeQJAAiuhI/xkH857FObZ/g7fka96pJSnA2g9PE0QKE8G+MTPTDgm8dg0sDPiLAqIViEcLJIVKV6PtI/d9y6rQ5uzpw==',
                        size: 200,
                        version: QrVersions.auto,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // Scrollable TextField
                      Container(
                        height: 150, // Adjust height as needed
                        child: TextField(
                          controller: _controller,
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
                          final text = _controller.text;
                          Clipboard.setData(ClipboardData(text: text));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Text copied to clipboard!'),
                            ),
                          );
                        },
                        child: Text('Copy Text'),
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
              SizedBox(
                height: 20,
              ),

              //add the back button
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Back',
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
