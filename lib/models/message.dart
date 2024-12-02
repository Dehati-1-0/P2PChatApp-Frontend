// lib/models/message.dart
// class Message {
//   final String sender;
//   final String content;
//   final DateTime timestamp;

//   Message({required this.sender, required this.content, required this.timestamp});
// }

class Message {
  final String senderUsername;
  final String senderIp;
  final String senderModelName;
  final String receiverUsername;
  final String receiverIp;
  final String receiverModelName;
  final String content;
  final DateTime timestamp;

  Message({
    required this.senderUsername,
    required this.senderIp,
    required this.senderModelName,
    required this.receiverUsername,
    required this.receiverIp,
    required this.receiverModelName,
    required this.content,
    required this.timestamp,
  });
}
