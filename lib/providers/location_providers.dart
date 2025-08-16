// lib/providers/location_providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/common/location_data.dart';
import '../services/location_service.dart';
import '../services/weather_service.dart';

part 'location_providers.g.dart';

// Location service provider
@riverpod
LocationService locationService(Ref ref) {
  final weatherService = WeatherService();
  return LocationService(weatherService);
}

// Current device location provider
@riverpod
class CurrentLocation extends _$CurrentLocation {
  @override
  Future<LocationData?> build() async {
    return null;
  }

  Future<void> getCurrentLocation() async {
    state = const AsyncValue.loading();
    try {
      final locationService = ref.read(locationServiceProvider);
      final location = await locationService.getCurrentLocation();
      state = AsyncValue.data(location);

      // Save current location
      await locationService.saveCurrentLocation(location);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> loadSavedLocation() async {
    state = const AsyncValue.loading();
    try {
      final locationService = ref.read(locationServiceProvider);
      final location = await locationService.getSavedCurrentLocation();
      state = AsyncValue.data(location);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

// Selected location provider (the location for which weather is shown)
@riverpod
class SelectedLocation extends _$SelectedLocation {
  @override
  LocationData? build() {
    return null;
  }

  void setLocation(LocationData location) {
    state = location;
    _saveSelectedLocation(location);
  }

  Future<void> _saveSelectedLocation(LocationData location) async {
    final locationService = ref.read(locationServiceProvider);
    await locationService.setSelectedLocation(location);
  }

  Future<void> loadSelectedLocation() async {
    final locationService = ref.read(locationServiceProvider);
    final location = await locationService.getSelectedLocation();
    if (location != null) {
      state = location;
    }
  }

  void clearSelection() {
    state = null;
  }
}

// Favorite locations provider
@riverpod
class FavoriteLocations extends _$FavoriteLocations {
  @override
  Future<List<LocationData>> build() async {
    return await _loadFavorites();
  }

  Future<List<LocationData>> _loadFavorites() async {
    final locationService = ref.read(locationServiceProvider);
    return await locationService.getFavoriteLocations();
  }

  Future<void> addToFavorites(LocationData location) async {
    state = const AsyncValue.loading();
    try {
      final locationService = ref.read(locationServiceProvider);
      await locationService.addToFavorites(location);

      final favorites = await _loadFavorites();
      state = AsyncValue.data(favorites);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> removeFromFavorites(LocationData location) async {
    state = const AsyncValue.loading();
    try {
      final locationService = ref.read(locationServiceProvider);
      await locationService.removeFromFavorites(location);

      final favorites = await _loadFavorites();
      state = AsyncValue.data(favorites);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<bool> isFavorite(LocationData location) async {
    final locationService = ref.read(locationServiceProvider);
    return await locationService.isFavorite(location);
  }

  Future<void> refreshFavorites() async {
    state = const AsyncValue.loading();
    try {
      final favorites = await _loadFavorites();
      state = AsyncValue.data(favorites);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

// Location search provider
@riverpod
class LocationSearch extends _$LocationSearch {
  @override
  Future<List<LocationData>?> build() async {
    return null;
  }

  Future<void> searchLocations(String query) async {
    if (query.trim().isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }

    state = const AsyncValue.loading();
    try {
      final locationService = ref.read(locationServiceProvider);
      final locations = await locationService.searchLocations(query);
      state = AsyncValue.data(locations);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void clearResults() {
    state = const AsyncValue.data([]);
  }
}

// Recent locations provider
@riverpod
class RecentLocations extends _$RecentLocations {
  @override
  Future<List<LocationData>> build() async {
    return await _loadRecentLocations();
  }

  Future<List<LocationData>> _loadRecentLocations() async {
    final locationService = ref.read(locationServiceProvider);
    return await locationService.getRecentLocations();
  }

  Future<void> refreshRecentLocations() async {
    state = const AsyncValue.loading();
    try {
      final recent = await _loadRecentLocations();
      state = AsyncValue.data(recent);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

// Provider to check if location permissions are granted
@riverpod
Future<bool> locationPermissionGranted(Ref ref) async {
  try {
    final locationService = ref.read(locationServiceProvider);
    await locationService.getCurrentLocation();
    return true;
  } catch (e) {
    return false;
  }
}
