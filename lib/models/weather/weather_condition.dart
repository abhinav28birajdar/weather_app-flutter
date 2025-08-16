// lib/models/weather/weather_condition.dart

enum WeatherCondition {
  clear,
  clouds,
  rain,
  snow,
  thunderstorm,
  drizzle,
  mist,
  smoke,
  haze,
  dust,
  fog,
  sand,
  ash,
  squall,
  tornado,
  unknown,
}

extension WeatherConditionExtension on WeatherCondition {
  String get displayName {
    switch (this) {
      case WeatherCondition.clear:
        return 'Clear';
      case WeatherCondition.clouds:
        return 'Cloudy';
      case WeatherCondition.rain:
        return 'Rain';
      case WeatherCondition.snow:
        return 'Snow';
      case WeatherCondition.thunderstorm:
        return 'Thunderstorm';
      case WeatherCondition.drizzle:
        return 'Drizzle';
      case WeatherCondition.mist:
        return 'Mist';
      case WeatherCondition.smoke:
        return 'Smoke';
      case WeatherCondition.haze:
        return 'Haze';
      case WeatherCondition.dust:
        return 'Dust';
      case WeatherCondition.fog:
        return 'Fog';
      case WeatherCondition.sand:
        return 'Sand';
      case WeatherCondition.ash:
        return 'Ash';
      case WeatherCondition.squall:
        return 'Squall';
      case WeatherCondition.tornado:
        return 'Tornado';
      case WeatherCondition.unknown:
        return 'Unknown';
    }
  }

  String get iconPath {
    switch (this) {
      case WeatherCondition.clear:
        return 'assets/sun.json';
      case WeatherCondition.clouds:
        return 'assets/cloud.json';
      case WeatherCondition.rain:
      case WeatherCondition.drizzle:
        return 'assets/rain.json';
      case WeatherCondition.snow:
        return 'assets/cloud.json'; // Using cloud for now since no snow asset
      case WeatherCondition.thunderstorm:
        return 'assets/light.json'; // Using light for thunderstorm
      default:
        return 'assets/cloud.json';
    }
  }

  List<String> get gradientColors {
    switch (this) {
      case WeatherCondition.clear:
        return ['#FF6B35', '#F7931E', '#FFD23F'];
      case WeatherCondition.clouds:
        return ['#4B6CB7', '#182848'];
      case WeatherCondition.rain:
      case WeatherCondition.drizzle:
        return ['#2E3192', '#1BFFFF'];
      case WeatherCondition.snow:
        return ['#E6DEDD', '#274046'];
      case WeatherCondition.thunderstorm:
        return ['#141E30', '#243B55'];
      default:
        return ['#4B6CB7', '#182848'];
    }
  }

  static WeatherCondition fromString(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return WeatherCondition.clear;
      case 'clouds':
        return WeatherCondition.clouds;
      case 'rain':
        return WeatherCondition.rain;
      case 'snow':
        return WeatherCondition.snow;
      case 'thunderstorm':
        return WeatherCondition.thunderstorm;
      case 'drizzle':
        return WeatherCondition.drizzle;
      case 'mist':
        return WeatherCondition.mist;
      case 'smoke':
        return WeatherCondition.smoke;
      case 'haze':
        return WeatherCondition.haze;
      case 'dust':
        return WeatherCondition.dust;
      case 'fog':
        return WeatherCondition.fog;
      case 'sand':
        return WeatherCondition.sand;
      case 'ash':
        return WeatherCondition.ash;
      case 'squall':
        return WeatherCondition.squall;
      case 'tornado':
        return WeatherCondition.tornado;
      default:
        return WeatherCondition.unknown;
    }
  }
}
