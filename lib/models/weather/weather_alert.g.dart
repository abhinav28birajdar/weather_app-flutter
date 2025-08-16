// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherAlert _$WeatherAlertFromJson(Map<String, dynamic> json) => WeatherAlert(
      senderName: json['senderName'] as String,
      event: json['event'] as String,
      start: DateTime.parse(json['start'] as String),
      end: DateTime.parse(json['end'] as String),
      description: json['description'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      severity: $enumDecode(_$AlertSeverityEnumMap, json['severity']),
    );

Map<String, dynamic> _$WeatherAlertToJson(WeatherAlert instance) =>
    <String, dynamic>{
      'senderName': instance.senderName,
      'event': instance.event,
      'start': instance.start.toIso8601String(),
      'end': instance.end.toIso8601String(),
      'description': instance.description,
      'tags': instance.tags,
      'severity': _$AlertSeverityEnumMap[instance.severity]!,
    };

const _$AlertSeverityEnumMap = {
  AlertSeverity.minor: 'minor',
  AlertSeverity.moderate: 'moderate',
  AlertSeverity.severe: 'severe',
  AlertSeverity.extreme: 'extreme',
  AlertSeverity.unknown: 'unknown',
};
