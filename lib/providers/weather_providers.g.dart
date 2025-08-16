// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weatherServiceHash() => r'006b9f4c78a0fc0bb6a81d945e1c74ccf9f098b3';

/// See also [weatherService].
@ProviderFor(weatherService)
final weatherServiceProvider = AutoDisposeProvider<WeatherService>.internal(
  weatherService,
  name: r'weatherServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weatherServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WeatherServiceRef = AutoDisposeProviderRef<WeatherService>;
String _$currentWeatherHash() => r'bbbd51aa2ef23adc5104ddede6bc22fb1151a5cd';

/// See also [CurrentWeather].
@ProviderFor(CurrentWeather)
final currentWeatherProvider =
    AutoDisposeAsyncNotifierProvider<CurrentWeather, Weather?>.internal(
  CurrentWeather.new,
  name: r'currentWeatherProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentWeatherHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentWeather = AutoDisposeAsyncNotifier<Weather?>;
String _$weatherForecastHash() => r'7de59847ab8e2479e3664e3864becfec4575c6fe';

/// See also [WeatherForecast].
@ProviderFor(WeatherForecast)
final weatherForecastProvider =
    AutoDisposeAsyncNotifierProvider<WeatherForecast, List<Forecast>?>.internal(
  WeatherForecast.new,
  name: r'weatherForecastProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weatherForecastHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WeatherForecast = AutoDisposeAsyncNotifier<List<Forecast>?>;
String _$dailyWeatherForecastHash() =>
    r'b98393caaa1ff70b0aa8fd33b45ec631718ba26f';

/// See also [DailyWeatherForecast].
@ProviderFor(DailyWeatherForecast)
final dailyWeatherForecastProvider = AutoDisposeAsyncNotifierProvider<
    DailyWeatherForecast, List<DailyForecast>?>.internal(
  DailyWeatherForecast.new,
  name: r'dailyWeatherForecastProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dailyWeatherForecastHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DailyWeatherForecast = AutoDisposeAsyncNotifier<List<DailyForecast>?>;
String _$airQualityDataHash() => r'dfd995c74c960f63ffda1dcb64ab77d304659ae8';

/// See also [AirQualityData].
@ProviderFor(AirQualityData)
final airQualityDataProvider =
    AutoDisposeAsyncNotifierProvider<AirQualityData, AirQuality?>.internal(
  AirQualityData.new,
  name: r'airQualityDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$airQualityDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AirQualityData = AutoDisposeAsyncNotifier<AirQuality?>;
String _$weatherAlertsDataHash() => r'0cee25de208580bb211626dcf208e25104e6b911';

/// See also [WeatherAlertsData].
@ProviderFor(WeatherAlertsData)
final weatherAlertsDataProvider = AutoDisposeAsyncNotifierProvider<
    WeatherAlertsData, List<WeatherAlert>?>.internal(
  WeatherAlertsData.new,
  name: r'weatherAlertsDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weatherAlertsDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WeatherAlertsData = AutoDisposeAsyncNotifier<List<WeatherAlert>?>;
String _$weatherDataHash() => r'722948b740e79ed678480a439d91261180a627e2';

/// See also [WeatherData].
@ProviderFor(WeatherData)
final weatherDataProvider =
    AutoDisposeAsyncNotifierProvider<WeatherData, void>.internal(
  WeatherData.new,
  name: r'weatherDataProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$weatherDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WeatherData = AutoDisposeAsyncNotifier<void>;
String _$lastUpdatedHash() => r'6e2440de513d69f9dec09f18a848a046da267298';

/// See also [LastUpdated].
@ProviderFor(LastUpdated)
final lastUpdatedProvider =
    AutoDisposeNotifierProvider<LastUpdated, DateTime?>.internal(
  LastUpdated.new,
  name: r'lastUpdatedProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$lastUpdatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LastUpdated = AutoDisposeNotifier<DateTime?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
