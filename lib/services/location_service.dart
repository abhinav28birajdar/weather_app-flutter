// lib/services/location_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/common/location_data.dart';
import 'weather_service.dart';

class LocationService {
  static const String _favoriteLocationsKey = 'favorite_locations';
  static const String _currentLocationKey = 'current_location';
  static const String _selectedLocationKey = 'selected_location';

  final WeatherService _weatherService;

  LocationService(this._weatherService);

  // Get current device location
  Future<LocationData> getCurrentLocation() async {
    return await _weatherService.getCurrentLocation();
  }

  // Save current location to preferences
  Future<void> saveCurrentLocation(LocationData location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentLocationKey, jsonEncode(location.toJson()));
  }

  // Get saved current location
  Future<LocationData?> getSavedCurrentLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final locationJson = prefs.getString(_currentLocationKey);

    if (locationJson != null) {
      try {
        final json = jsonDecode(locationJson) as Map<String, dynamic>;
        return LocationData.fromJson(json);
      } catch (e) {
        // If parsing fails, remove corrupted data
        await prefs.remove(_currentLocationKey);
        return null;
      }
    }

    return null;
  }

  // Set selected location
  Future<void> setSelectedLocation(LocationData location) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedLocationKey, jsonEncode(location.toJson()));
  }

  // Get selected location
  Future<LocationData?> getSelectedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final locationJson = prefs.getString(_selectedLocationKey);

    if (locationJson != null) {
      try {
        final json = jsonDecode(locationJson) as Map<String, dynamic>;
        return LocationData.fromJson(json);
      } catch (e) {
        // If parsing fails, remove corrupted data
        await prefs.remove(_selectedLocationKey);
        return null;
      }
    }

    return null;
  }

  // Add location to favorites
  Future<void> addToFavorites(LocationData location) async {
    final favorites = await getFavoriteLocations();

    // Check if location already exists
    final exists = favorites.any((loc) =>
        loc.lat.toStringAsFixed(4) == location.lat.toStringAsFixed(4) &&
        loc.lon.toStringAsFixed(4) == location.lon.toStringAsFixed(4));

    if (!exists) {
      favorites.add(
          location.copyWith(isFavorite: true, lastUpdated: DateTime.now()));
      await _saveFavoriteLocations(favorites);
    }
  }

  // Remove location from favorites
  Future<void> removeFromFavorites(LocationData location) async {
    final favorites = await getFavoriteLocations();
    favorites.removeWhere((loc) =>
        loc.lat.toStringAsFixed(4) == location.lat.toStringAsFixed(4) &&
        loc.lon.toStringAsFixed(4) == location.lon.toStringAsFixed(4));

    await _saveFavoriteLocations(favorites);
  }

  // Check if location is in favorites
  Future<bool> isFavorite(LocationData location) async {
    final favorites = await getFavoriteLocations();
    return favorites.any((loc) =>
        loc.lat.toStringAsFixed(4) == location.lat.toStringAsFixed(4) &&
        loc.lon.toStringAsFixed(4) == location.lon.toStringAsFixed(4));
  }

  // Get all favorite locations
  Future<List<LocationData>> getFavoriteLocations() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritesJson = prefs.getStringList(_favoriteLocationsKey);

    if (favoritesJson != null) {
      try {
        return favoritesJson
            .map((jsonStr) => LocationData.fromJson(
                jsonDecode(jsonStr) as Map<String, dynamic>))
            .toList();
      } catch (e) {
        // If parsing fails, clear corrupted data
        await prefs.remove(_favoriteLocationsKey);
        return [];
      }
    }

    return [];
  }

  // Save favorite locations
  Future<void> _saveFavoriteLocations(List<LocationData> locations) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = locations.map((loc) => jsonEncode(loc.toJson())).toList();
    await prefs.setStringList(_favoriteLocationsKey, jsonList);
  }

  // Search for locations
  Future<List<LocationData>> searchLocations(String query) async {
    if (query.trim().isEmpty) return [];

    try {
      return await _weatherService.searchLocations(query);
    } catch (e) {
      throw LocationException('Failed to search locations: $e');
    }
  }

  // Get location by coordinates
  Future<LocationData> getLocationByCoordinates(double lat, double lon) async {
    try {
      return await _weatherService.getLocationByCoordinates(lat, lon);
    } catch (e) {
      throw LocationException('Failed to get location: $e');
    }
  }

  // Clear all saved data
  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favoriteLocationsKey);
    await prefs.remove(_currentLocationKey);
    await prefs.remove(_selectedLocationKey);
  }

  // Get recently accessed locations (favorites + current + selected)
  Future<List<LocationData>> getRecentLocations() async {
    final favorites = await getFavoriteLocations();
    final current = await getSavedCurrentLocation();
    final selected = await getSelectedLocation();

    final recent = <LocationData>[];

    // Add current location if available
    if (current != null) {
      recent.add(current);
    }

    // Add selected location if different from current
    if (selected != null &&
        (current == null || !_locationsEqual(selected, current))) {
      recent.add(selected);
    }

    // Add favorites that are not already in the list
    for (final favorite in favorites) {
      if (!recent.any((loc) => _locationsEqual(loc, favorite))) {
        recent.add(favorite);
      }
    }

    return recent;
  }

  bool _locationsEqual(LocationData loc1, LocationData loc2) {
    return loc1.lat.toStringAsFixed(4) == loc2.lat.toStringAsFixed(4) &&
        loc1.lon.toStringAsFixed(4) == loc2.lon.toStringAsFixed(4);
  }
}

class LocationException implements Exception {
  final String message;

  LocationException(this.message);

  @override
  String toString() => 'LocationException: $message';
}
