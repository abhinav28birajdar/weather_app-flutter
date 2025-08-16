// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherModelImpl _$$WeatherModelImplFromJson(Map<String, dynamic> json) =>
    _$WeatherModelImpl(
      id: (json['id'] as num).toInt(),
      cityName: json['cityName'] as String,
      country: json['country'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      tempMin: (json['tempMin'] as num).toDouble(),
      tempMax: (json['tempMax'] as num).toDouble(),
      feelsLike: (json['feelsLike'] as num).toDouble(),
      humidity: (json['humidity'] as num).toInt(),
      pressure: (json['pressure'] as num).toInt(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
      cloudiness: (json['cloudiness'] as num).toInt(),
      visibility: (json['visibility'] as num).toInt(),
      description: json['description'] as String,
      condition: $enumDecode(_$WeatherConditionEnumMap, json['condition']),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$WeatherModelImplToJson(_$WeatherModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cityName': instance.cityName,
      'country': instance.country,
      'temperature': instance.temperature,
      'tempMin': instance.tempMin,
      'tempMax': instance.tempMax,
      'feelsLike': instance.feelsLike,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'windSpeed': instance.windSpeed,
      'cloudiness': instance.cloudiness,
      'visibility': instance.visibility,
      'description': instance.description,
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
      'timestamp': instance.timestamp.toIso8601String(),
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.clear: 'clear',
  WeatherCondition.partlyCloudy: 'partlyCloudy',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.rain: 'rain',
  WeatherCondition.snow: 'snow',
  WeatherCondition.thunderstorm: 'thunderstorm',
  WeatherCondition.mist: 'mist',
  WeatherCondition.unknown: 'unknown',
};
