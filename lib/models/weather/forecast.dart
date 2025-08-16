// lib/models/weather/forecast.dart
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'weather_condition.dart';

part 'forecast.g.dart';

@JsonSerializable()
class Forecast extends Equatable {
  final DateTime dateTime;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final WeatherCondition condition;
  final String description;
  final int humidity;
  final double pressure;
  final double windSpeed;
  final int windDirection;
  final int cloudiness;
  final double? rainVolume;
  final double? snowVolume;

  const Forecast({
    required this.dateTime,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.condition,
    required this.description,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.windDirection,
    required this.cloudiness,
    this.rainVolume,
    this.snowVolume,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) =>
      _$ForecastFromJson(json);
  Map<String, dynamic> toJson() => _$ForecastToJson(this);

  factory Forecast.fromOpenWeatherMapJson(Map<String, dynamic> json) {
    final main = json['main'] as Map<String, dynamic>;
    final weather = (json['weather'] as List)[0] as Map<String, dynamic>;
    final wind = json['wind'] as Map<String, dynamic>? ?? {};
    final clouds = json['clouds'] as Map<String, dynamic>? ?? {};
    final rain = json['rain'] as Map<String, dynamic>?;
    final snow = json['snow'] as Map<String, dynamic>?;

    return Forecast(
      dateTime: DateTime.fromMillisecondsSinceEpoch((json['dt'] as int) * 1000),
      temperature: (main['temp'] as num).toDouble(),
      tempMin: (main['temp_min'] as num).toDouble(),
      tempMax: (main['temp_max'] as num).toDouble(),
      condition:
          WeatherConditionExtension.fromString(weather['main'] as String),
      description: weather['description'] as String,
      humidity: main['humidity'] as int,
      pressure: (main['pressure'] as num).toDouble(),
      windSpeed: (wind['speed'] as num?)?.toDouble() ?? 0.0,
      windDirection: (wind['deg'] as num?)?.toInt() ?? 0,
      cloudiness: (clouds['all'] as num?)?.toInt() ?? 0,
      rainVolume: rain?['3h'] as double?,
      snowVolume: snow?['3h'] as double?,
    );
  }

  @override
  List<Object?> get props => [
        dateTime,
        temperature,
        tempMin,
        tempMax,
        condition,
        description,
        humidity,
        pressure,
        windSpeed,
        windDirection,
        cloudiness,
        rainVolume,
        snowVolume,
      ];
}

@JsonSerializable()
class DailyForecast extends Equatable {
  final DateTime date;
  final double tempMin;
  final double tempMax;
  final WeatherCondition condition;
  final String description;
  final int humidity;
  final double pressure;
  final double windSpeed;
  final int windDirection;
  final int cloudiness;
  final double? rainVolume;
  final double? snowVolume;
  final List<Forecast> hourlyForecasts;

  const DailyForecast({
    required this.date,
    required this.tempMin,
    required this.tempMax,
    required this.condition,
    required this.description,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.windDirection,
    required this.cloudiness,
    this.rainVolume,
    this.snowVolume,
    this.hourlyForecasts = const [],
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) =>
      _$DailyForecastFromJson(json);
  Map<String, dynamic> toJson() => _$DailyForecastToJson(this);

  factory DailyForecast.fromHourlyForecasts(List<Forecast> hourlyForecasts) {
    if (hourlyForecasts.isEmpty) {
      throw ArgumentError('Cannot create DailyForecast from empty list');
    }

    final date = DateTime(
      hourlyForecasts.first.dateTime.year,
      hourlyForecasts.first.dateTime.month,
      hourlyForecasts.first.dateTime.day,
    );

    final temps = hourlyForecasts.map((f) => f.temperature).toList();
    final tempMin = temps.reduce((a, b) => a < b ? a : b);
    final tempMax = temps.reduce((a, b) => a > b ? a : b);

    // Use the most common condition for the day
    final conditionCounts = <WeatherCondition, int>{};
    for (final forecast in hourlyForecasts) {
      conditionCounts[forecast.condition] =
          (conditionCounts[forecast.condition] ?? 0) + 1;
    }
    final condition =
        conditionCounts.entries.reduce((a, b) => a.value > b.value ? a : b).key;

    // Average other values
    final avgHumidity =
        (hourlyForecasts.map((f) => f.humidity).reduce((a, b) => a + b) /
                hourlyForecasts.length)
            .round();
    final avgPressure =
        hourlyForecasts.map((f) => f.pressure).reduce((a, b) => a + b) /
            hourlyForecasts.length;
    final avgWindSpeed =
        hourlyForecasts.map((f) => f.windSpeed).reduce((a, b) => a + b) /
            hourlyForecasts.length;
    final avgWindDirection =
        (hourlyForecasts.map((f) => f.windDirection).reduce((a, b) => a + b) /
                hourlyForecasts.length)
            .round();
    final avgCloudiness =
        (hourlyForecasts.map((f) => f.cloudiness).reduce((a, b) => a + b) /
                hourlyForecasts.length)
            .round();

    final totalRain =
        hourlyForecasts.map((f) => f.rainVolume ?? 0.0).reduce((a, b) => a + b);
    final totalSnow =
        hourlyForecasts.map((f) => f.snowVolume ?? 0.0).reduce((a, b) => a + b);

    return DailyForecast(
      date: date,
      tempMin: tempMin,
      tempMax: tempMax,
      condition: condition,
      description: condition.displayName,
      humidity: avgHumidity,
      pressure: avgPressure,
      windSpeed: avgWindSpeed,
      windDirection: avgWindDirection,
      cloudiness: avgCloudiness,
      rainVolume: totalRain > 0 ? totalRain : null,
      snowVolume: totalSnow > 0 ? totalSnow : null,
      hourlyForecasts: hourlyForecasts,
    );
  }

  @override
  List<Object?> get props => [
        date,
        tempMin,
        tempMax,
        condition,
        description,
        humidity,
        pressure,
        windSpeed,
        windDirection,
        cloudiness,
        rainVolume,
        snowVolume,
        hourlyForecasts,
      ];
}
