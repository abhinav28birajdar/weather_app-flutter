// lib/models/weather/weather.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'weather_condition.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather extends Equatable {
  final double temperature;
  final double tempMin;
  final double tempMax;
  final double feelsLike;
  final int humidity;
  final double pressure;
  final double windSpeed;
  final int windDirection;
  final double visibility;
  final int cloudiness;
  final double uvIndex;
  final WeatherCondition condition;
  final String description;
  final String cityName;
  final String country;
  final DateTime lastUpdated;
  final DateTime sunrise;
  final DateTime sunset;

  const Weather({
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.windDirection,
    required this.visibility,
    required this.cloudiness,
    required this.uvIndex,
    required this.condition,
    required this.description,
    required this.cityName,
    required this.country,
    required this.lastUpdated,
    required this.sunrise,
    required this.sunset,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);

  factory Weather.fromOpenWeatherMapJson(Map<String, dynamic> json) {
    final main = json['main'] as Map<String, dynamic>;
    final weather = (json['weather'] as List)[0] as Map<String, dynamic>;
    final wind = json['wind'] as Map<String, dynamic>? ?? {};
    final sys = json['sys'] as Map<String, dynamic>? ?? {};
    final clouds = json['clouds'] as Map<String, dynamic>? ?? {};

    return Weather(
      temperature: (main['temp'] as num).toDouble(),
      tempMin: (main['temp_min'] as num).toDouble(),
      tempMax: (main['temp_max'] as num).toDouble(),
      feelsLike: (main['feels_like'] as num).toDouble(),
      humidity: main['humidity'] as int,
      pressure: (main['pressure'] as num).toDouble(),
      windSpeed: (wind['speed'] as num?)?.toDouble() ?? 0.0,
      windDirection: (wind['deg'] as num?)?.toInt() ?? 0,
      visibility: ((json['visibility'] as num?) ?? 10000).toDouble(),
      cloudiness: (clouds['all'] as num?)?.toInt() ?? 0,
      uvIndex: 0.0, // UV Index not available in current weather API
      condition:
          WeatherConditionExtension.fromString(weather['main'] as String),
      description: weather['description'] as String,
      cityName: json['name'] as String,
      country: (sys['country'] as String?) ?? '',
      lastUpdated: DateTime.now(),
      sunrise: DateTime.fromMillisecondsSinceEpoch(
          (sys['sunrise'] as int? ?? 0) * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(
          (sys['sunset'] as int? ?? 0) * 1000),
    );
  }

  Weather copyWith({
    double? temperature,
    double? tempMin,
    double? tempMax,
    double? feelsLike,
    int? humidity,
    double? pressure,
    double? windSpeed,
    int? windDirection,
    double? visibility,
    int? cloudiness,
    double? uvIndex,
    WeatherCondition? condition,
    String? description,
    String? cityName,
    String? country,
    DateTime? lastUpdated,
    DateTime? sunrise,
    DateTime? sunset,
  }) {
    return Weather(
      temperature: temperature ?? this.temperature,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      feelsLike: feelsLike ?? this.feelsLike,
      humidity: humidity ?? this.humidity,
      pressure: pressure ?? this.pressure,
      windSpeed: windSpeed ?? this.windSpeed,
      windDirection: windDirection ?? this.windDirection,
      visibility: visibility ?? this.visibility,
      cloudiness: cloudiness ?? this.cloudiness,
      uvIndex: uvIndex ?? this.uvIndex,
      condition: condition ?? this.condition,
      description: description ?? this.description,
      cityName: cityName ?? this.cityName,
      country: country ?? this.country,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
    );
  }

  bool get isDaytime {
    final now = DateTime.now();
    return now.isAfter(sunrise) && now.isBefore(sunset);
  }

  String get windDirectionText {
    const directions = [
      'N',
      'NNE',
      'NE',
      'ENE',
      'E',
      'ESE',
      'SE',
      'SSE',
      'S',
      'SSW',
      'SW',
      'WSW',
      'W',
      'WNW',
      'NW',
      'NNW'
    ];
    final index = (windDirection / 22.5).round() % 16;
    return directions[index];
  }

  @override
  List<Object?> get props => [
        temperature,
        tempMin,
        tempMax,
        feelsLike,
        humidity,
        pressure,
        windSpeed,
        windDirection,
        visibility,
        cloudiness,
        uvIndex,
        condition,
        description,
        cityName,
        country,
        lastUpdated,
        sunrise,
        sunset,
      ];
}
