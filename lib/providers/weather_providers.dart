// lib/providers/weather_providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import '../models/weather/weather.dart';
import '../models/weather/forecast.dart';
import '../models/weather/air_quality.dart';
import '../models/weather/weather_alert.dart';
import '../models/common/location_data.dart';
import '../services/weather_service.dart';
import 'location_providers.dart';

part 'weather_providers.g.dart';

// Weather service provider
@riverpod
WeatherService weatherService(Ref ref) {
  return WeatherService();
}

// Current weather provider
@riverpod
class CurrentWeather extends _$CurrentWeather {
  @override
  Future<Weather?> build() async {
    return null;
  }

  Future<void> loadWeather(LocationData location) async {
    state = const AsyncValue.loading();
    try {
      final weatherService = ref.read(weatherServiceProvider);
      final weather =
          await weatherService.getCurrentWeather(location.lat, location.lon);
      state = AsyncValue.data(weather);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshWeather() async {
    final currentLocation = ref.read(selectedLocationProvider);
    if (currentLocation != null) {
      await loadWeather(currentLocation);
    }
  }
}

// Forecast provider
@riverpod
class WeatherForecast extends _$WeatherForecast {
  @override
  Future<List<Forecast>?> build() async {
    return null;
  }

  Future<void> loadForecast(LocationData location) async {
    state = const AsyncValue.loading();
    try {
      final weatherService = ref.read(weatherServiceProvider);
      final forecast =
          await weatherService.getForecast(location.lat, location.lon);
      state = AsyncValue.data(forecast);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshForecast() async {
    final currentLocation = ref.read(selectedLocationProvider);
    if (currentLocation != null) {
      await loadForecast(currentLocation);
    }
  }
}

// Daily forecast provider
@riverpod
class DailyWeatherForecast extends _$DailyWeatherForecast {
  @override
  Future<List<DailyForecast>?> build() async {
    return null;
  }

  Future<void> loadDailyForecast(LocationData location) async {
    state = const AsyncValue.loading();
    try {
      final weatherService = ref.read(weatherServiceProvider);
      final dailyForecast =
          await weatherService.getDailyForecast(location.lat, location.lon);
      state = AsyncValue.data(dailyForecast);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshDailyForecast() async {
    final currentLocation = ref.read(selectedLocationProvider);
    if (currentLocation != null) {
      await loadDailyForecast(currentLocation);
    }
  }
}

// Air quality provider
@riverpod
class AirQualityData extends _$AirQualityData {
  @override
  Future<AirQuality?> build() async {
    return null;
  }

  Future<void> loadAirQuality(LocationData location) async {
    state = const AsyncValue.loading();
    try {
      final weatherService = ref.read(weatherServiceProvider);
      final airQuality =
          await weatherService.getAirQuality(location.lat, location.lon);
      state = AsyncValue.data(airQuality);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshAirQuality() async {
    final currentLocation = ref.read(selectedLocationProvider);
    if (currentLocation != null) {
      await loadAirQuality(currentLocation);
    }
  }
}

// Weather alerts provider
@riverpod
class WeatherAlertsData extends _$WeatherAlertsData {
  @override
  Future<List<WeatherAlert>?> build() async {
    return null;
  }

  Future<void> loadWeatherAlerts(LocationData location) async {
    state = const AsyncValue.loading();
    try {
      final weatherService = ref.read(weatherServiceProvider);
      final alerts =
          await weatherService.getWeatherAlerts(location.lat, location.lon);
      state = AsyncValue.data(alerts);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> refreshWeatherAlerts() async {
    final currentLocation = ref.read(selectedLocationProvider);
    if (currentLocation != null) {
      await loadWeatherAlerts(currentLocation);
    }
  }
}

// Combined weather data provider
@riverpod
class WeatherData extends _$WeatherData {
  @override
  Future<void> build() async {
    // This provider orchestrates loading all weather data
  }

  Future<void> loadAllWeatherData(LocationData location) async {
    try {
      // Load current weather first since it's the most important
      await ref.read(currentWeatherProvider.notifier).loadWeather(location);

      // Load other data in parallel
      await Future.wait([
        ref.read(weatherForecastProvider.notifier).loadForecast(location),
        ref
            .read(dailyWeatherForecastProvider.notifier)
            .loadDailyForecast(location),
        ref.read(airQualityDataProvider.notifier).loadAirQuality(location),
        ref
            .read(weatherAlertsDataProvider.notifier)
            .loadWeatherAlerts(location),
      ], eagerError: false)
          .then((results) {
        // Update last updated timestamp even if some requests fail
        ref.read(lastUpdatedProvider.notifier).updateTimestamp();
      });
    } catch (e, stackTrace) {
      debugPrint('Error loading weather data: $e\n$stackTrace');
      rethrow;
    }
  }

  Future<void> refreshAllWeatherData() async {
    final currentLocation = ref.read(selectedLocationProvider);
    if (currentLocation != null) {
      await loadAllWeatherData(currentLocation);
    }
  }
}

// Last updated provider
@riverpod
class LastUpdated extends _$LastUpdated {
  @override
  DateTime? build() {
    return null;
  }

  void updateTimestamp() {
    state = DateTime.now();
  }
}
