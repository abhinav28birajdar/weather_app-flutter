// lib/services/preferences_service.dart
import 'package:shared_preferences/shared_preferences.dart';

enum TemperatureUnit { celsius, fahrenheit }

enum WindSpeedUnit { kmh, mph, ms }

enum PressureUnit { hpa, mmhg, inhg }

enum DistanceUnit { km, miles }

class PreferencesService {
  static const String _temperatureUnitKey = 'temperature_unit';
  static const String _windSpeedUnitKey = 'wind_speed_unit';
  static const String _pressureUnitKey = 'pressure_unit';
  static const String _distanceUnitKey = 'distance_unit';
  static const String _isDarkModeKey = 'is_dark_mode';
  static const String _isSystemThemeKey = 'is_system_theme';
  static const String _notificationsEnabledKey = 'notifications_enabled';
  static const String _weatherAlertsEnabledKey = 'weather_alerts_enabled';
  static const String _locationUpdatesEnabledKey = 'location_updates_enabled';
  static const String _autoRefreshEnabledKey = 'auto_refresh_enabled';
  static const String _refreshIntervalKey = 'refresh_interval';
  static const String _showDetailsKey = 'show_details';
  static const String _show24HourFormatKey = 'show_24_hour_format';
  static const String _firstLaunchKey = 'first_launch';

  // Temperature unit
  Future<TemperatureUnit> getTemperatureUnit() async {
    final prefs = await SharedPreferences.getInstance();
    final unitIndex = prefs.getInt(_temperatureUnitKey) ?? 0;
    return TemperatureUnit.values[unitIndex];
  }

  Future<void> setTemperatureUnit(TemperatureUnit unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_temperatureUnitKey, unit.index);
  }

  // Wind speed unit
  Future<WindSpeedUnit> getWindSpeedUnit() async {
    final prefs = await SharedPreferences.getInstance();
    final unitIndex = prefs.getInt(_windSpeedUnitKey) ?? 0;
    return WindSpeedUnit.values[unitIndex];
  }

  Future<void> setWindSpeedUnit(WindSpeedUnit unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_windSpeedUnitKey, unit.index);
  }

  // Pressure unit
  Future<PressureUnit> getPressureUnit() async {
    final prefs = await SharedPreferences.getInstance();
    final unitIndex = prefs.getInt(_pressureUnitKey) ?? 0;
    return PressureUnit.values[unitIndex];
  }

  Future<void> setPressureUnit(PressureUnit unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_pressureUnitKey, unit.index);
  }

  // Distance unit
  Future<DistanceUnit> getDistanceUnit() async {
    final prefs = await SharedPreferences.getInstance();
    final unitIndex = prefs.getInt(_distanceUnitKey) ?? 0;
    return DistanceUnit.values[unitIndex];
  }

  Future<void> setDistanceUnit(DistanceUnit unit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_distanceUnitKey, unit.index);
  }

  // Dark mode
  Future<bool> isDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isDarkModeKey) ?? false;
  }

  Future<void> setDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isDarkModeKey, isDark);
  }

  // System theme
  Future<bool> isSystemTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isSystemThemeKey) ?? true;
  }

  Future<void> setSystemTheme(bool isSystem) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isSystemThemeKey, isSystem);
  }

  // Notifications
  Future<bool> areNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsEnabledKey) ?? true;
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsEnabledKey, enabled);
  }

  // Weather alerts
  Future<bool> areWeatherAlertsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_weatherAlertsEnabledKey) ?? true;
  }

  Future<void> setWeatherAlertsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_weatherAlertsEnabledKey, enabled);
  }

  // Location updates
  Future<bool> areLocationUpdatesEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_locationUpdatesEnabledKey) ?? true;
  }

  Future<void> setLocationUpdatesEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_locationUpdatesEnabledKey, enabled);
  }

  // Auto refresh
  Future<bool> isAutoRefreshEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_autoRefreshEnabledKey) ?? true;
  }

  Future<void> setAutoRefreshEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_autoRefreshEnabledKey, enabled);
  }

  // Refresh interval (in minutes)
  Future<int> getRefreshInterval() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_refreshIntervalKey) ?? 30;
  }

  Future<void> setRefreshInterval(int minutes) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_refreshIntervalKey, minutes);
  }

  // Show details
  Future<bool> shouldShowDetails() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_showDetailsKey) ?? false;
  }

  Future<void> setShowDetails(bool show) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_showDetailsKey, show);
  }

  // 24-hour format
  Future<bool> shouldShow24HourFormat() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_show24HourFormatKey) ?? true;
  }

  Future<void> setShow24HourFormat(bool show24Hour) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_show24HourFormatKey, show24Hour);
  }

  // First launch
  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_firstLaunchKey) ?? true;
  }

  Future<void> setFirstLaunchCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstLaunchKey, false);
  }

  // Clear all preferences
  Future<void> clearAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Temperature conversion utilities
  double convertTemperature(double celsius, TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.celsius:
        return celsius;
      case TemperatureUnit.fahrenheit:
        return (celsius * 9 / 5) + 32;
    }
  }

  String getTemperatureSymbol(TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.celsius:
        return '°C';
      case TemperatureUnit.fahrenheit:
        return '°F';
    }
  }

  // Wind speed conversion utilities
  double convertWindSpeed(double kmh, WindSpeedUnit unit) {
    switch (unit) {
      case WindSpeedUnit.kmh:
        return kmh;
      case WindSpeedUnit.mph:
        return kmh * 0.621371;
      case WindSpeedUnit.ms:
        return kmh * 0.277778;
    }
  }

  String getWindSpeedSymbol(WindSpeedUnit unit) {
    switch (unit) {
      case WindSpeedUnit.kmh:
        return 'km/h';
      case WindSpeedUnit.mph:
        return 'mph';
      case WindSpeedUnit.ms:
        return 'm/s';
    }
  }

  // Pressure conversion utilities
  double convertPressure(double hpa, PressureUnit unit) {
    switch (unit) {
      case PressureUnit.hpa:
        return hpa;
      case PressureUnit.mmhg:
        return hpa * 0.750062;
      case PressureUnit.inhg:
        return hpa * 0.029530;
    }
  }

  String getPressureSymbol(PressureUnit unit) {
    switch (unit) {
      case PressureUnit.hpa:
        return 'hPa';
      case PressureUnit.mmhg:
        return 'mmHg';
      case PressureUnit.inhg:
        return 'inHg';
    }
  }

  // Distance conversion utilities
  double convertDistance(double km, DistanceUnit unit) {
    switch (unit) {
      case DistanceUnit.km:
        return km;
      case DistanceUnit.miles:
        return km * 0.621371;
    }
  }

  String getDistanceSymbol(DistanceUnit unit) {
    switch (unit) {
      case DistanceUnit.km:
        return 'km';
      case DistanceUnit.miles:
        return 'mi';
    }
  }
}
