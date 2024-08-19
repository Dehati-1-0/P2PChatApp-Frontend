import 'package:flutter/services.dart';

class MessageSender {
  static const platform = MethodChannel('com.example.p2pchat/sendMessage');

  static Future<bool> sendMessage(String message, String serverIp, int serverPort) async {
    try {
      final bool result = await platform.invokeMethod('sendMessage', {
        'message': message,
        'serverIp': serverIp,
        'serverPort': serverPort,
      });
      return result;
    } on PlatformException catch (e) {
      print("Failed to send message: '${e.message}'.");
      return false;
    }
  }
}