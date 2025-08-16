// lib/constants/asset_paths.dart
class AssetPaths {
  static const String _baseLottiePath = 'assets/lottie/';

  // Maps OpenWeather icon codes to local Lottie JSON file paths.
  // Ensure these exact files exist in your 'assets/lottie/' folder.
  static String getLottieIcon(String iconCode) {
    switch (iconCode) {
      // Day icons (d suffix for day)
      case '01d':
        return '${_baseLottiePath}clear_day.json'; // Clear sky day
      case '02d':
        return '${_baseLottiePath}partly_cloudy_day.json'; // Few clouds day
      case '03d':
        return '${_baseLottiePath}cloudy.json'; // Scattered clouds day
      case '04d':
        return '${_baseLottiePath}cloudy.json'; // Broken clouds day (often same icon as scattered)
      case '09d':
        return '${_baseLottiePath}rain.json'; // Shower rain day
      case '10d':
        return '${_baseLottiePath}heavy_rain.json'; // Rain day (using heavy for more impact)
      case '11d':
        return '${_baseLottiePath}thunderstorm.json'; // Thunderstorm day
      case '13d':
        return '${_baseLottiePath}snow.json'; // Snow day
      case '50d':
        return '${_baseLottiePath}mist.json'; // Mist/fog/haze day

      // Night icons (n suffix for night)
      case '01n':
        return '${_baseLottiePath}clear_night.json'; // Clear sky night
      case '02n':
        return '${_baseLottiePath}partly_cloudy_night.json'; // Few clouds night
      case '03n':
        return '${_baseLottiePath}cloudy.json'; // Scattered clouds night
      case '04n':
        return '${_baseLottiePath}cloudy.json'; // Broken clouds night
      case '09n':
        return '${_baseLottiePath}rain.json'; // Shower rain night
      case '10n':
        return '${_baseLottiePath}heavy_rain.json'; // Rain night
      case '11n':
        return '${_baseLottiePath}thunderstorm.json'; // Thunderstorm night
      case '13n':
        return '${_baseLottiePath}snow.json'; // Snow night
      case '50n':
        return '${_baseLottiePath}mist.json'; // Mist/fog/haze night

      default:
        return '${_baseLottiePath}clear_day.json'; // Fallback to clear day if icon code is unknown
    }
  }

  static const String loadingLottie =
      '${_baseLottiePath}loading.json'; // Path to a generic loading animation

  // Additional assets for enhanced features
  static const String windLottie = '${_baseLottiePath}wind.json';
  static const String pressureLottie = '${_baseLottiePath}pressure.json';
  static const String humidityLottie = '${_baseLottiePath}humidity.json';
  static const String uvIndexLottie = '${_baseLottiePath}uv_index.json';
  static const String alertLottie = '${_baseLottiePath}alert.json';
  static const String noDataLottie = '${_baseLottiePath}no_data.json';
}
