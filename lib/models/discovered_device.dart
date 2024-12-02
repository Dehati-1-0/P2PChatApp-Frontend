class DiscoveredDevice {
  final String modelName;
  final String ip;
  final String username;
  late DateTime lastSeen;

  DiscoveredDevice({required this.modelName, required this.ip, required this.username}) {
    lastSeen = DateTime.now();
  }

  factory DiscoveredDevice.fromJson(Map<String, dynamic> json) {
    return DiscoveredDevice(
      modelName: json['modelName'],
      ip: json['ip'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'modelName': modelName,
      'ip': ip,
      'username': username,
    };
  }
}