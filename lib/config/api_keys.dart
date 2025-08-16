// lib/config/api_keys.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiKeys {
  static String get openWeatherMapApiKey =>
      dotenv.env['OPENWEATHER_API_KEY'] ?? '';
  static String get apiKey => dotenv.env['OPENWEATHER_API_KEY'] ?? '';
  static String get mapApiKey => dotenv.env['GOOGLE_MAPS_API_KEY'] ?? '';
  static String get notificationKey => dotenv.env['NOTIFICATION_API_KEY'] ?? '';
  static String get weatherAlertsApiKey =>
      dotenv.env['WEATHER_ALERTS_API_KEY'] ?? '';
  static String get radarMapApiKey => dotenv.env['RADAR_MAP_API_KEY'] ?? '';

  // App configuration
  static String get appName => dotenv.env['APP_NAME'] ?? 'NimbusWeather';
  static String get appVersion => dotenv.env['APP_VERSION'] ?? '1.0.0';
  static bool get enableAnalytics =>
      dotenv.env['ENABLE_ANALYTICS']?.toLowerCase() == 'true';
  static bool get enableCrashReporting =>
      dotenv.env['ENABLE_CRASH_REPORTING']?.toLowerCase() == 'true';
}
