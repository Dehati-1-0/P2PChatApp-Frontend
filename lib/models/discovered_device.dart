class DiscoveredDevice {
  final String modelName;
  final String ip;
  late DateTime lastSeen;

  DiscoveredDevice({required this.modelName, required this.ip}) {
    lastSeen = DateTime.now();
  }

  factory DiscoveredDevice.fromJson(Map<String, dynamic> json) {
    return DiscoveredDevice(
      modelName: json['modelName'],
      ip: json['ip'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'modelName': modelName,
      'ip': ip,
    };
  }
}
