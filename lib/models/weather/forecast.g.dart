// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Forecast _$ForecastFromJson(Map<String, dynamic> json) => Forecast(
      dateTime: DateTime.parse(json['dateTime'] as String),
      temperature: (json['temperature'] as num).toDouble(),
      tempMin: (json['tempMin'] as num).toDouble(),
      tempMax: (json['tempMax'] as num).toDouble(),
      condition: $enumDecode(_$WeatherConditionEnumMap, json['condition']),
      description: json['description'] as String,
      humidity: (json['humidity'] as num).toInt(),
      pressure: (json['pressure'] as num).toDouble(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
      windDirection: (json['windDirection'] as num).toInt(),
      cloudiness: (json['cloudiness'] as num).toInt(),
      rainVolume: (json['rainVolume'] as num?)?.toDouble(),
      snowVolume: (json['snowVolume'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ForecastToJson(Forecast instance) => <String, dynamic>{
      'dateTime': instance.dateTime.toIso8601String(),
      'temperature': instance.temperature,
      'tempMin': instance.tempMin,
      'tempMax': instance.tempMax,
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
      'description': instance.description,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'windSpeed': instance.windSpeed,
      'windDirection': instance.windDirection,
      'cloudiness': instance.cloudiness,
      'rainVolume': instance.rainVolume,
      'snowVolume': instance.snowVolume,
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

DailyForecast _$DailyForecastFromJson(Map<String, dynamic> json) =>
    DailyForecast(
      date: DateTime.parse(json['date'] as String),
      tempMin: (json['tempMin'] as num).toDouble(),
      tempMax: (json['tempMax'] as num).toDouble(),
      condition: $enumDecode(_$WeatherConditionEnumMap, json['condition']),
      description: json['description'] as String,
      humidity: (json['humidity'] as num).toInt(),
      pressure: (json['pressure'] as num).toDouble(),
      windSpeed: (json['windSpeed'] as num).toDouble(),
      windDirection: (json['windDirection'] as num).toInt(),
      cloudiness: (json['cloudiness'] as num).toInt(),
      rainVolume: (json['rainVolume'] as num?)?.toDouble(),
      snowVolume: (json['snowVolume'] as num?)?.toDouble(),
      hourlyForecasts: (json['hourlyForecasts'] as List<dynamic>?)
              ?.map((e) => Forecast.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$DailyForecastToJson(DailyForecast instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'tempMin': instance.tempMin,
      'tempMax': instance.tempMax,
      'condition': _$WeatherConditionEnumMap[instance.condition]!,
      'description': instance.description,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'windSpeed': instance.windSpeed,
      'windDirection': instance.windDirection,
      'cloudiness': instance.cloudiness,
      'rainVolume': instance.rainVolume,
      'snowVolume': instance.snowVolume,
      'hourlyForecasts': instance.hourlyForecasts,
    };
