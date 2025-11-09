class SpeedTest {
  final String id;
  final DateTime timestamp;
  final double downloadSpeed;
  final double uploadSpeed;
  final int ping;
  final String? label;
  final bool isFavorite;

  const SpeedTest({
    required this.id,
    required this.timestamp,
    required this.downloadSpeed,
    required this.uploadSpeed,
    required this.ping,
    this.label,
    this.isFavorite = false,
  });

  SpeedTest copyWith({
    String? id,
    DateTime? timestamp,
    double? downloadSpeed,
    double? uploadSpeed,
    int? ping,
    String? label,
    bool? isFavorite,
  }) {
    return SpeedTest(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      downloadSpeed: downloadSpeed ?? this.downloadSpeed,
      uploadSpeed: uploadSpeed ?? this.uploadSpeed,
      ping: ping ?? this.ping,
      label: label ?? this.label,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
