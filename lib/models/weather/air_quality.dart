// lib/models/weather/air_quality.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'air_quality.g.dart';

@JsonSerializable()
class AirQuality extends Equatable {
  final int aqi; // Air Quality Index (1-5)
  final double co; // Carbon monoxide μg/m³
  final double no; // Nitric oxide μg/m³
  final double no2; // Nitrogen dioxide μg/m³
  final double o3; // Ozone μg/m³
  final double so2; // Sulfur dioxide μg/m³
  final double pm2_5; // Fine particles μg/m³
  final double pm10; // Coarse particulate matter μg/m³
  final double nh3; // Ammonia μg/m³
  final DateTime dateTime;

  const AirQuality({
    required this.aqi,
    required this.co,
    required this.no,
    required this.no2,
    required this.o3,
    required this.so2,
    required this.pm2_5,
    required this.pm10,
    required this.nh3,
    required this.dateTime,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) =>
      _$AirQualityFromJson(json);
  Map<String, dynamic> toJson() => _$AirQualityToJson(this);

  factory AirQuality.fromOpenWeatherMapJson(Map<String, dynamic> json) {
    final list = json['list'] as List;
    if (list.isEmpty) {
      throw ArgumentError('No air quality data available');
    }

    final data = list.first as Map<String, dynamic>;
    final main = data['main'] as Map<String, dynamic>;
    final components = data['components'] as Map<String, dynamic>;

    return AirQuality(
      aqi: main['aqi'] as int,
      co: (components['co'] as num).toDouble(),
      no: (components['no'] as num).toDouble(),
      no2: (components['no2'] as num).toDouble(),
      o3: (components['o3'] as num).toDouble(),
      so2: (components['so2'] as num).toDouble(),
      pm2_5: (components['pm2_5'] as num).toDouble(),
      pm10: (components['pm10'] as num).toDouble(),
      nh3: (components['nh3'] as num).toDouble(),
      dateTime: DateTime.fromMillisecondsSinceEpoch((data['dt'] as int) * 1000),
    );
  }

  String get qualityDescription {
    switch (aqi) {
      case 1:
        return 'Good';
      case 2:
        return 'Fair';
      case 3:
        return 'Moderate';
      case 4:
        return 'Poor';
      case 5:
        return 'Very Poor';
      default:
        return 'Unknown';
    }
  }

  String get qualityColor {
    switch (aqi) {
      case 1:
        return '#00E400'; // Green
      case 2:
        return '#FFFF00'; // Yellow
      case 3:
        return '#FF7E00'; // Orange
      case 4:
        return '#FF0000'; // Red
      case 5:
        return '#8F3F97'; // Purple
      default:
        return '#808080'; // Gray
    }
  }

  @override
  List<Object?> get props =>
      [aqi, co, no, no2, o3, so2, pm2_5, pm10, nh3, dateTime];
}
