// lib/constants/app_constants.dart

class AppConstants {
  // --- Spacing & Sizing ---
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double cardMargin = 12.0; // Margin applied between AppCards
  static const double borderRadius =
      20.0; // Consistent border radius for cards and major elements

  // --- Animation Durations ---
  static const Duration animationDurationFast = Duration(milliseconds: 300);
  static const Duration animationDurationNormal = Duration(milliseconds: 600);
  static const Duration animationDurationSlow =
      Duration(seconds: 2); // Particularly for background gradient transitions

  // --- Responsive Sizing Multipliers (relative to screen width) ---
  static const double tempFontSizeMultiplier =
      0.18; // For the large current temperature display
  static const double locationFontSizeMultiplier =
      0.08; // For the city/location name display

  // --- Default Settings Values ---
  static const String defaultUnit =
      'metric'; // 'metric' for Celsius, 'imperial' for Fahrenheit
  static const bool defaultDynamicTheme =
      true; // Dynamic theme enabled by default
  static const bool defaultNotificationsEnabled =
      true; // Notifications enabled by default
  static const bool defaultSevereWeatherAlerts =
      true; // Severe weather alerts enabled by default
  static const int defaultRefreshInterval =
      15; // Minutes between automatic refresh

  // --- Chart Configuration ---
  static const int chartDataPoints = 24; // Number of data points for charts
  static const double chartHeight = 200.0; // Default chart height
  static const double chartAnimationDuration =
      1.5; // Chart animation duration in seconds

  // --- Map Configuration ---
  static const double defaultMapZoom = 10.0;
  static const int mapTileSize = 256;

  // --- Weather Alerts ---
  static const List<String> severeWeatherTypes = [
    'Tornado',
    'Severe Thunderstorm',
    'Flash Flood',
    'Blizzard',
    'Ice Storm',
    'Hurricane',
    'Heat Wave',
    'Cold Wave'
  ];

  // --- Cache Configuration ---
  static const Duration cacheExpiration = Duration(minutes: 15);
  static const int maxCachedLocations = 10;
}
