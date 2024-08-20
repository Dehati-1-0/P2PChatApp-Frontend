import 'package:flutter/services.dart';

class MessageSender {
  static const platform = MethodChannel('com.example.p2pchat/sendMessage');

  static Future<Map<String, dynamic>> sendMessage(String message, String serverIp, int serverPort) async {
    try {
      final bool result = await platform.invokeMethod('sendMessage', {
        'message': message,
        'serverIp': serverIp,
        'serverPort': serverPort,
      });
      return {'success': result, 'serverIp': serverIp, 'serverPort': serverPort};
    } on PlatformException catch (e) {
      print("Failed to send message: '${e.message}'.");
      return {'success': false, 'serverIp': serverIp, 'serverPort': serverPort};
    }
  }
}