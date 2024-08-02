class DiscoveredDevice {
  final String ip;
  final String modelName;

  DiscoveredDevice({required this.ip, required this.modelName});

  factory DiscoveredDevice.fromJson(Map<String, dynamic> json) {
    return DiscoveredDevice(
      ip: json['ip'],
      modelName: json['modelName'],
    );
  }
}
