// lib/models/weather/weather_alert.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_alert.g.dart';

enum AlertSeverity {
  minor,
  moderate,
  severe,
  extreme,
  unknown,
}

@JsonSerializable()
class WeatherAlert extends Equatable {
  final String senderName;
  final String event;
  final DateTime start;
  final DateTime end;
  final String description;
  final List<String> tags;
  final AlertSeverity severity;

  const WeatherAlert({
    required this.senderName,
    required this.event,
    required this.start,
    required this.end,
    required this.description,
    required this.tags,
    required this.severity,
  });

  factory WeatherAlert.fromJson(Map<String, dynamic> json) => _$WeatherAlertFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherAlertToJson(this);

  factory WeatherAlert.fromOpenWeatherMapJson(Map<String, dynamic> json) {
    return WeatherAlert(
      senderName: json['sender_name'] as String? ?? '',
      event: json['event'] as String,
      start: DateTime.fromMillisecondsSinceEpoch((json['start'] as int) * 1000),
      end: DateTime.fromMillisecondsSinceEpoch((json['end'] as int) * 1000),
      description: json['description'] as String,
      tags: (json['tags'] as List?)?.cast<String>() ?? [],
      severity: _parseSeverity(json['tags'] as List?),
    );
  }

  static AlertSeverity _parseSeverity(List? tags) {
    if (tags == null) return AlertSeverity.unknown;
    
    for (final tag in tags) {
      final tagStr = tag.toString().toLowerCase();
      if (tagStr.contains('extreme')) return AlertSeverity.extreme;
      if (tagStr.contains('severe')) return AlertSeverity.severe;
      if (tagStr.contains('moderate')) return AlertSeverity.moderate;
      if (tagStr.contains('minor')) return AlertSeverity.minor;
    }
    
    return AlertSeverity.unknown;
  }

  String get severityText {
    switch (severity) {
      case AlertSeverity.minor:
        return 'Minor';
      case AlertSeverity.moderate:
        return 'Moderate';
      case AlertSeverity.severe:
        return 'Severe';
      case AlertSeverity.extreme:
        return 'Extreme';
      case AlertSeverity.unknown:
        return 'Unknown';
    }
  }

  String get severityColor {
    switch (severity) {
      case AlertSeverity.minor:
        return '#FFEB3B'; // Yellow
      case AlertSeverity.moderate:
        return '#FF9800'; // Orange
      case AlertSeverity.severe:
        return '#FF5722'; // Deep Orange
      case AlertSeverity.extreme:
        return '#F44336'; // Red
      case AlertSeverity.unknown:
        return '#9E9E9E'; // Gray
    }
  }

  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(start) && now.isBefore(end);
  }

  Duration get duration => end.difference(start);

  @override
  List<Object?> get props => [senderName, event, start, end, description, tags, severity];
}
