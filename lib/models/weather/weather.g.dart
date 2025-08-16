// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      temperature: (json['temperature'] as num).toDouble(),
      tempMin: (json['tempMin'] as num).toDouble(),
      tempMax: (json['tempMax'] as num).toDouble(),
      feelsLike: (json['feelsLike'] as num).toDouble(),
      humidity: (json['humidity'] as num).toInt(),
      pressure: (json['pressure'] as num).toDouble(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
      windDirection: (json['windDirection'] as num).toInt(),
      visibility: (json['visibility'] as num).toDouble(),
      cloudiness: (json['cloudiness'] as num).toInt(),
      uvIndex: (json['uvIndex'] as num).toDouble(),
      condition: $enumDecode(_$WeatherConditionEnumMap, json['condition']),
      description: json['description'] as String,
      cityName: json['cityName'] as String,
      country: json['country'] as String,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      sunrise: DateTime.parse(json['sunrise'] as String),
      sunset: DateTime.parse(json['sunset'] as String),
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'temperature': instance.temperature,
      'tempMin': instance.tempMin,
      'tempMax': instance.tempMax,
      'feelsLike': instance.feelsLike,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'windSpeed': instance.windSpeed,
      'windDirection': instance.windDirection,
      'visibility': instance.visibility,
      'cloudiness': instance.cloudiness,
      'uvIndex': instance.uvIndex,
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
      'description': instance.description,
      'cityName': instance.cityName,
      'country': instance.country,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'sunrise': instance.sunrise.toIso8601String(),
      'sunset': instance.sunset.toIso8601String(),
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.clear: 'clear',
  WeatherCondition.clouds: 'clouds',
  WeatherCondition.rain: 'rain',
  WeatherCondition.snow: 'snow',
  WeatherCondition.thunderstorm: 'thunderstorm',
  WeatherCondition.drizzle: 'drizzle',
  WeatherCondition.mist: 'mist',
  WeatherCondition.smoke: 'smoke',
  WeatherCondition.haze: 'haze',
  WeatherCondition.dust: 'dust',
  WeatherCondition.fog: 'fog',
  WeatherCondition.sand: 'sand',
  WeatherCondition.ash: 'ash',
  WeatherCondition.squall: 'squall',
  WeatherCondition.tornado: 'tornado',
  WeatherCondition.unknown: 'unknown',
};
