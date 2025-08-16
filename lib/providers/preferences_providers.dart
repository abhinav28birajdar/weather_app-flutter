// lib/providers/preferences_providers.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/preferences_service.dart';

part 'preferences_providers.g.dart';

// Preferences service provider
@riverpod
PreferencesService preferencesService(Ref ref) {
  return PreferencesService();
}

// Temperature unit provider
@riverpod
class TemperatureUnitNotifier extends _$TemperatureUnitNotifier {
  @override
  Future<TemperatureUnit> build() async {
    final prefs = ref.read(preferencesServiceProvider);
    return await prefs.getTemperatureUnit();
  }

  Future<void> setUnit(TemperatureUnit unit) async {
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.setTemperatureUnit(unit);
    state = AsyncValue.data(unit);
  }
}

// Wind speed unit provider
@riverpod
class WindSpeedUnitNotifier extends _$WindSpeedUnitNotifier {
  @override
  Future<WindSpeedUnit> build() async {
    final prefs = ref.read(preferencesServiceProvider);
    return await prefs.getWindSpeedUnit();
  }

  Future<void> setUnit(WindSpeedUnit unit) async {
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.setWindSpeedUnit(unit);
    state = AsyncValue.data(unit);
  }
}

// Pressure unit provider
@riverpod
class PressureUnitNotifier extends _$PressureUnitNotifier {
  @override
  Future<PressureUnit> build() async {
    final prefs = ref.read(preferencesServiceProvider);
    return await prefs.getPressureUnit();
  }

  Future<void> setUnit(PressureUnit unit) async {
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.setPressureUnit(unit);
    state = AsyncValue.data(unit);
  }
}

// Distance unit provider
@riverpod
class DistanceUnitNotifier extends _$DistanceUnitNotifier {
  @override
  Future<DistanceUnit> build() async {
    final prefs = ref.read(preferencesServiceProvider);
    return await prefs.getDistanceUnit();
  }

  Future<void> setUnit(DistanceUnit unit) async {
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.setDistanceUnit(unit);
    state = AsyncValue.data(unit);
  }
}

// Dark mode provider
@riverpod
class DarkModeNotifier extends _$DarkModeNotifier {
  @override
  Future<bool> build() async {
    final prefs = ref.read(preferencesServiceProvider);
    return await prefs.isDarkMode();
  }

  Future<void> setDarkMode(bool isDark) async {
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.setDarkMode(isDark);
    state = AsyncValue.data(isDark);
  }

  Future<void> toggleDarkMode() async {
    final current = state.valueOrNull ?? false;
    await setDarkMode(!current);
  }
}

// System theme provider
@riverpod
class SystemThemeNotifier extends _$SystemThemeNotifier {
  @override
  Future<bool> build() async {
    final prefs = ref.read(preferencesServiceProvider);
    return await prefs.isSystemTheme();
  }

  Future<void> setSystemTheme(bool isSystem) async {
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.setSystemTheme(isSystem);
    state = AsyncValue.data(isSystem);
  }
}

// Notifications enabled provider
@riverpod
class NotificationsEnabledNotifier extends _$NotificationsEnabledNotifier {
  @override
  Future<bool> build() async {
    final prefs = ref.read(preferencesServiceProvider);
    return await prefs.areNotificationsEnabled();
  }

  Future<void> setEnabled(bool enabled) async {
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.setNotificationsEnabled(enabled);
    state = AsyncValue.data(enabled);
  }
}

// Weather alerts enabled provider
@riverpod
class WeatherAlertsEnabledNotifier extends _$WeatherAlertsEnabledNotifier {
  @override
  Future<bool> build() async {
    final prefs = ref.read(preferencesServiceProvider);
    return await prefs.areWeatherAlertsEnabled();
  }

  Future<void> setEnabled(bool enabled) async {
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.setWeatherAlertsEnabled(enabled);
    state = AsyncValue.data(enabled);
  }
}

// Location updates enabled provider
@riverpod
class LocationUpdatesEnabledNotifier extends _$LocationUpdatesEnabledNotifier {
  @override
  Future<bool> build() async {
    final prefs = ref.read(preferencesServiceProvider);
    return await prefs.areLocationUpdatesEnabled();
  }

  Future<void> setEnabled(bool enabled) async {
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.setLocationUpdatesEnabled(enabled);
    state = AsyncValue.data(enabled);
  }
}

// Auto refresh enabled provider
@riverpod
class AutoRefreshEnabledNotifier extends _$AutoRefreshEnabledNotifier {
  @override
  Future<bool> build() async {
    final prefs = ref.read(preferencesServiceProvider);
    return await prefs.isAutoRefreshEnabled();
  }

  Future<void> setEnabled(bool enabled) async {
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.setAutoRefreshEnabled(enabled);
    state = AsyncValue.data(enabled);
  }
}

// Refresh interval provider
@riverpod
class RefreshIntervalNotifier extends _$RefreshIntervalNotifier {
  @override
  Future<int> build() async {
    final prefs = ref.read(preferencesServiceProvider);
    return await prefs.getRefreshInterval();
  }

  Future<void> setInterval(int minutes) async {
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.setRefreshInterval(minutes);
    state = AsyncValue.data(minutes);
  }
}

// Show details provider
@riverpod
class ShowDetailsNotifier extends _$ShowDetailsNotifier {
  @override
  Future<bool> build() async {
    final prefs = ref.read(preferencesServiceProvider);
    return await prefs.shouldShowDetails();
  }

  Future<void> setShowDetails(bool show) async {
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.setShowDetails(show);
    state = AsyncValue.data(show);
  }
}

// 24-hour format provider
@riverpod
class Show24HourFormatNotifier extends _$Show24HourFormatNotifier {
  @override
  Future<bool> build() async {
    final prefs = ref.read(preferencesServiceProvider);
    return await prefs.shouldShow24HourFormat();
  }

  Future<void> setShow24HourFormat(bool show24Hour) async {
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.setShow24HourFormat(show24Hour);
    state = AsyncValue.data(show24Hour);
  }
}

// First launch provider
@riverpod
class FirstLaunchNotifier extends _$FirstLaunchNotifier {
  @override
  Future<bool> build() async {
    final prefs = ref.read(preferencesServiceProvider);
    return await prefs.isFirstLaunch();
  }

  Future<void> setFirstLaunchCompleted() async {
    final prefs = ref.read(preferencesServiceProvider);
    await prefs.setFirstLaunchCompleted();
    state = const AsyncValue.data(false);
  }
}
