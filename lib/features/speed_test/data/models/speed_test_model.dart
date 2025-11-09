import 'package:speedra/features/speed_test/domain/entities/speed_test.dart';

class SpeedTestModel extends SpeedTest {
  const SpeedTestModel({
    required super.id,
    required super.timestamp,
    required super.downloadSpeed,
    required super.uploadSpeed,
    required super.ping,
    super.label,
    super.isFavorite,
  });

  factory SpeedTestModel.fromJson(Map<String, dynamic> json) {
    return SpeedTestModel(
      id: json['id'],
      timestamp: DateTime.parse(json['timestamp']),
      downloadSpeed: json['downloadSpeed'].toDouble(),
      uploadSpeed: json['uploadSpeed'].toDouble(),
      ping: json['ping'],
      label: json['label'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'downloadSpeed': downloadSpeed,
      'uploadSpeed': uploadSpeed,
      'ping': ping,
      'label': label,
      'isFavorite': isFavorite,
    };
  }

  factory SpeedTestModel.fromEntity(SpeedTest entity) {
    return SpeedTestModel(
      id: entity.id,
      timestamp: entity.timestamp,
      downloadSpeed: entity.downloadSpeed,
      uploadSpeed: entity.uploadSpeed,
      ping: entity.ping,
      label: entity.label,
      isFavorite: entity.isFavorite,
    );
  }
}
