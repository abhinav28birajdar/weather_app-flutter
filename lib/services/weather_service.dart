// lib/services/weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../config/api_keys.dart';
import '../models/common/location_data.dart';
import '../models/weather/weather.dart';
import '../models/weather/forecast.dart';
import '../models/weather/air_quality.dart';
import '../models/weather/weather_alert.dart';

class WeatherService {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String _geoUrl = 'https://api.openweathermap.org/geo/1.0';
  final String _apiKey = ApiKeys.openWeatherMapApiKey;

  // Get current weather by coordinates
  Future<Weather> getCurrentWeather(double lat, double lon) async {
    final url = '$_baseUrl/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric';
    
    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return Weather.fromOpenWeatherMapJson(json);
      } else {
        throw WeatherException('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      throw WeatherException('Error fetching weather: $e');
    }
  }

  // Get current weather by city name
  Future<Weather> getCurrentWeatherByCity(String cityName) async {
    final url = '$_baseUrl/weather?q=$cityName&appid=$_apiKey&units=metric';
    
    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return Weather.fromOpenWeatherMapJson(json);
      } else {
        throw WeatherException('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      throw WeatherException('Error fetching weather: $e');
    }
  }

  // Get 5-day forecast (3-hour intervals)
  Future<List<Forecast>> getForecast(double lat, double lon) async {
    final url = '$_baseUrl/forecast?lat=$lat&lon=$lon&appid=$_apiKey&units=metric';
    
    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final list = json['list'] as List;
        
        return list
            .map((item) => Forecast.fromOpenWeatherMapJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw WeatherException('Failed to load forecast data: ${response.statusCode}');
      }
    } catch (e) {
      throw WeatherException('Error fetching forecast: $e');
    }
  }

  // Get daily forecasts from hourly data
  Future<List<DailyForecast>> getDailyForecast(double lat, double lon) async {
    final hourlyForecasts = await getForecast(lat, lon);
    
    // Group forecasts by day
    final Map<String, List<Forecast>> groupedByDay = {};
    
    for (final forecast in hourlyForecasts) {
      final dateKey = '${forecast.dateTime.year}-${forecast.dateTime.month}-${forecast.dateTime.day}';
      groupedByDay[dateKey] ??= [];
      groupedByDay[dateKey]!.add(forecast);
    }
    
    // Create daily forecasts
    final dailyForecasts = <DailyForecast>[];
    for (final dayForecasts in groupedByDay.values) {
      if (dayForecasts.isNotEmpty) {
        dailyForecasts.add(DailyForecast.fromHourlyForecasts(dayForecasts));
      }
    }
    
    return dailyForecasts;
  }

  // Get air quality data
  Future<AirQuality> getAirQuality(double lat, double lon) async {
    final url = '$_baseUrl/air_pollution?lat=$lat&lon=$lon&appid=$_apiKey';
    
    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return AirQuality.fromOpenWeatherMapJson(json);
      } else {
        throw WeatherException('Failed to load air quality data: ${response.statusCode}');
      }
    } catch (e) {
      throw WeatherException('Error fetching air quality: $e');
    }
  }

  // Get weather alerts (using One Call API)
  Future<List<WeatherAlert>> getWeatherAlerts(double lat, double lon) async {
    // Note: This requires the One Call API which may require a different subscription
    final url = '$_baseUrl/onecall?lat=$lat&lon=$lon&appid=$_apiKey&exclude=minutely';
    
    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final alerts = json['alerts'] as List?;
        
        if (alerts != null) {
          return alerts
              .map((alert) => WeatherAlert.fromOpenWeatherMapJson(alert as Map<String, dynamic>))
              .toList();
        }
        
        return [];
      } else {
        // If One Call API is not available, return empty list
        return [];
      }
    } catch (e) {
      // Log error but don't throw since alerts are optional
      print('Warning: Could not fetch weather alerts: $e');
      return [];
    }
  }

  // Search for locations
  Future<List<LocationData>> searchLocations(String query) async {
    final url = '$_geoUrl/direct?q=$query&limit=5&appid=$_apiKey';
    
    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final list = jsonDecode(response.body) as List;
        
        return list.map((item) {
          final json = item as Map<String, dynamic>;
          return LocationData(
            name: json['name'] as String,
            lat: (json['lat'] as num).toDouble(),
            lon: (json['lon'] as num).toDouble(),
            country: json['country'] as String?,
            state: json['state'] as String?,
          );
        }).toList();
      } else {
        throw WeatherException('Failed to search locations: ${response.statusCode}');
      }
    } catch (e) {
      throw WeatherException('Error searching locations: $e');
    }
  }

  // Get location data by coordinates (reverse geocoding)
  Future<LocationData> getLocationByCoordinates(double lat, double lon) async {
    final url = '$_geoUrl/reverse?lat=$lat&lon=$lon&limit=1&appid=$_apiKey';
    
    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final list = jsonDecode(response.body) as List;
        
        if (list.isNotEmpty) {
          final json = list.first as Map<String, dynamic>;
          return LocationData(
            name: json['name'] as String,
            lat: lat,
            lon: lon,
            country: json['country'] as String?,
            state: json['state'] as String?,
          );
        } else {
          throw WeatherException('No location found for coordinates');
        }
      } else {
        throw WeatherException('Failed to get location: ${response.statusCode}');
      }
    } catch (e) {
      throw WeatherException('Error getting location: $e');
    }
  }

  // Get current device location
  Future<LocationData> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw WeatherException('Location services are disabled');
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw WeatherException('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw WeatherException('Location permissions are permanently denied');
    }

    // Get current position
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Get location name using reverse geocoding
    return await getLocationByCoordinates(position.latitude, position.longitude);
  }
}

class WeatherException implements Exception {
  final String message;
  
  WeatherException(this.message);
  
  @override
  String toString() => 'WeatherException: $message';
}
