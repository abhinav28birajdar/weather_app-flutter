import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_model.freezed.dart';
part 'weather_model.g.dart';

@freezed
class WeatherModel with _$WeatherModel {
  const factory WeatherModel({
    required int id,
    required String cityName,
    required String country,
    required double temperature,
    required double tempMin,
    required double tempMax,
    required double feelsLike,
    required int humidity,
    required int pressure,
    required double windSpeed,
    required int cloudiness,
    required int visibility,
    required String description,
    required WeatherCondition condition,
    required DateTime timestamp,
  }) = _WeatherModel;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);
}

enum WeatherCondition {
  @JsonValue('clear')
  clear,
  @JsonValue('partlyCloudy')
  partlyCloudy,
  @JsonValue('cloudy')
  cloudy,
  @JsonValue('rain')
  rain,
  @JsonValue('snow')
  snow,
  @JsonValue('thunderstorm')
  thunderstorm,
  @JsonValue('mist')
  mist,
  @JsonValue('unknown')
  unknown;

  List<String> get gradientColors {
    switch (this) {
      case WeatherCondition.clear:
        return ['#4A90E2', '#87CEEB'];
      case WeatherCondition.partlyCloudy:
        return ['#757F9A', '#D7DDE8'];
      case WeatherCondition.cloudy:
        return ['#6B7280', '#9CA3AF'];
      case WeatherCondition.rain:
        return ['#2C3E50', '#3498DB'];
      case WeatherCondition.snow:
        return ['#E0E0E0', '#FFFFFF'];
      case WeatherCondition.thunderstorm:
        return ['#2C3E50', '#1B1464'];
      case WeatherCondition.mist:
        return ['#8E9EAB', '#EEF2F3'];
      case WeatherCondition.unknown:
        return ['#6B7280', '#9CA3AF'];
    }
  }

  String get assetName {
    switch (this) {
      case WeatherCondition.clear:
        return 'sun.json';
      case WeatherCondition.partlyCloudy:
        return 'sun.json';
      case WeatherCondition.cloudy:
        return 'cloud.json';
      case WeatherCondition.rain:
        return 'rain.json';
      case WeatherCondition.snow:
        return 'cloud.json';
      case WeatherCondition.thunderstorm:
        return 'rain.json';
      case WeatherCondition.mist:
        return 'cloud.json';
      case WeatherCondition.unknown:
        return 'cloud.json';
    }
  }
}
