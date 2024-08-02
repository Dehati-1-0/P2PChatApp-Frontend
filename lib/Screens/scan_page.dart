import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qrText;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Expanded(
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                    overlay: QrScannerOverlayShape(
                      borderColor: Colors.red,
                      borderRadius: 10,
                      borderLength: 30,
                      borderWidth: 10,
                      cutOutSize: 300,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Align QR code within the frame to scan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (qrText != null)
                  ? Text('Scan result: $qrText')
                  : Text('Scan a code'),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData.code;
      });
      controller.dispose(); // Stop the camera after getting the result
      Navigator.pushNamed(context, '/chat'); // Navigate to the chat page
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
