import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/common/animated_gradient_container.dart';
import '../../widgets/common/loading_indicator.dart'
    show WeatherLoadingIndicator;
import '../../widgets/common/weather_icon.dart';
import '../../widgets/common/error_view.dart';
import '../../widgets/common/pull_to_refresh_indicator.dart';
import '../../models/weather/weather_condition.dart';
import '../../providers/weather_providers.dart';
import '../../providers/location_providers.dart';
import '../../providers/preferences_providers.dart';
import '../../services/preferences_service.dart';
import '../search/search_screen.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeWeatherData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initializeWeatherData() async {
    if (!mounted) return;

    try {
      debugPrint('Starting weather data initialization...');

      // Load saved location first
      debugPrint('Loading saved location...');
      await ref.read(selectedLocationProvider.notifier).loadSelectedLocation();

      // Check if we got a saved location
      var selectedLocation = ref.read(selectedLocationProvider);
      debugPrint(selectedLocation != null
          ? 'Loaded saved location: ${selectedLocation.name}'
          : 'No saved location found');

      if (selectedLocation == null) {
        debugPrint('Attempting to get current location...');
        await ref.read(currentLocationProvider.notifier).getCurrentLocation();

        final currentLocation = ref.read(currentLocationProvider).valueOrNull;
        debugPrint(currentLocation != null
            ? 'Got current location: ${currentLocation.name}'
            : 'Failed to get current location');

        if (currentLocation != null && mounted) {
          ref
              .read(selectedLocationProvider.notifier)
              .setLocation(currentLocation);
          selectedLocation = currentLocation;
        }
      }

      // Load weather data for the selected location
      if (selectedLocation != null && mounted) {
        debugPrint('Loading current weather for ${selectedLocation.name}');
        try {
          // Load current weather first
          await ref
              .read(currentWeatherProvider.notifier)
              .loadWeather(selectedLocation);
          debugPrint('Successfully loaded current weather');

          if (!mounted) return;

          // Then load all other weather data in parallel
          debugPrint('Loading additional weather data...');
          await ref
              .read(weatherDataProvider.notifier)
              .loadAllWeatherData(selectedLocation);
          debugPrint('Successfully loaded all weather data');
        } catch (weatherError, weatherStack) {
          debugPrint('Error loading weather data:');
          debugPrint('Error: $weatherError');
          debugPrint('Stack trace:\n$weatherStack');
          rethrow;
        }
      } else {
        debugPrint('WARNING: No location available to load weather data');
      }
    } catch (e, stackTrace) {
      debugPrint('CRITICAL ERROR initializing weather data:');
      debugPrint('Error: $e');
      debugPrint('Stack trace:\n$stackTrace');
      rethrow; // Rethrow to trigger error UI
    }
  }

  Future<void> _refreshWeatherData() async {
    if (!mounted) return;
    await ref.read(weatherDataProvider.notifier).refreshAllWeatherData();
    ref.read(lastUpdatedProvider.notifier).updateTimestamp();
  }

  @override
  Widget build(BuildContext context) {
    final currentWeather = ref.watch(currentWeatherProvider);
    final selectedLocation = ref.watch(selectedLocationProvider);
    final temperatureUnit = ref.watch(temperatureUnitNotifierProvider);

    // If no location is selected, show location selection options
    if (selectedLocation == null) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 64,
                  color: Colors.blue,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Select a location to view weather',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'You can use your current location or search for a city',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      await ref
                          .read(currentLocationProvider.notifier)
                          .getCurrentLocation();
                      if (!mounted) return;

                      final currentLocation =
                          ref.read(currentLocationProvider).valueOrNull;
                      if (currentLocation != null) {
                        ref
                            .read(selectedLocationProvider.notifier)
                            .setLocation(currentLocation);
                      } else {
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Could not detect your location.'),
                          ),
                        );
                      }
                    } catch (e) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Could not get your location. Please check your location permissions.'),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.my_location),
                  label: const Text('Use my location'),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('Search for a city'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      floatingActionButton: currentWeather.hasError
          ? FloatingActionButton(
              onPressed: _initializeWeatherData,
              child: const Icon(Icons.refresh),
            )
          : null,
      body: currentWeather.when(
        data: (weather) {
          if (weather == null) {
            return const Center(
              child: WeatherLoadingIndicator(
                message: 'Select a location to view weather',
              ),
            );
          }

          final gradientColors = weather.condition.gradientColors
              .map((hex) => Color(int.parse(hex.replaceAll('#', '0xFF'))))
              .toList();

          return AnimatedGradientContainer(
            colors: gradientColors,
            child: SafeArea(
              child: PullToRefreshIndicator(
                onRefresh: _refreshWeatherData,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context, weather, selectedLocation),
                        const SizedBox(height: 32),
                        _buildMainWeatherInfo(
                            context, weather, temperatureUnit),
                        const SizedBox(height: 32),
                        _buildWeatherDetails(context, weather),
                        const SizedBox(height: 32),
                        _buildForecastSection(context),
                        const SizedBox(height: 32),
                        _buildAdditionalInfo(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        loading: () => const WeatherLoadingIndicator(),
        error: (error, stackTrace) => ErrorView(
          title: 'Weather Data Unavailable',
          message: error.toString(),
          onRetry: _refreshWeatherData,
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, weather, selectedLocation) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                weather.cityName,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (weather.country.isNotEmpty)
                Text(
                  weather.country,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.8),
                      ),
                ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.search, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                // Navigate to settings screen
              },
              icon: const Icon(Icons.settings, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMainWeatherInfo(BuildContext context, weather,
      AsyncValue<TemperatureUnit> temperatureUnit) {
    return Center(
      child: Column(
        children: [
          WeatherIcon(
            condition: weather.condition,
            size: 120,
          ),
          const SizedBox(height: 16),
          temperatureUnit.when(
            data: (unit) {
              final temp = unit == TemperatureUnit.celsius
                  ? weather.temperature
                  : (weather.temperature * 9 / 5) + 32;
              final symbol = unit == TemperatureUnit.celsius ? '°C' : '°F';

              return Text(
                '${temp.round()}$symbol',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 64,
                    ),
              );
            },
            loading: () => const CircularProgressIndicator(color: Colors.white),
            error: (_, __) => Text(
              '${weather.temperature.round()}°C',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 64,
                  ),
            ),
          ),
          Text(
            weather.description.toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                  letterSpacing: 1.2,
                ),
          ),
          const SizedBox(height: 8),
          temperatureUnit.when(
            data: (unit) {
              final tempMin = unit == TemperatureUnit.celsius
                  ? weather.tempMin
                  : (weather.tempMin * 9 / 5) + 32;
              final tempMax = unit == TemperatureUnit.celsius
                  ? weather.tempMax
                  : (weather.tempMax * 9 / 5) + 32;
              final symbol = unit == TemperatureUnit.celsius ? '°C' : '°F';

              return Text(
                'H: ${tempMax.round()}$symbol  L: ${tempMin.round()}$symbol',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.8),
                    ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => Text(
              'H: ${weather.tempMax.round()}°C  L: ${weather.tempMin.round()}°C',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color:
                        Colors.white.withValues(alpha: 204), // 0.8 * 255 ≈ 204
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetails(BuildContext context, weather) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDetailItem(
                context,
                Icons.opacity,
                'Humidity',
                '${weather.humidity}%',
              ),
              _buildDetailItem(
                context,
                Icons.visibility,
                'Visibility',
                '${(weather.visibility / 1000).toStringAsFixed(1)} km',
              ),
              _buildDetailItem(
                context,
                Icons.air,
                'Wind',
                '${weather.windSpeed.toStringAsFixed(1)} km/h',
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDetailItem(
                context,
                Icons.thermostat,
                'Feels like',
                '${weather.feelsLike.round()}°C',
              ),
              _buildDetailItem(
                context,
                Icons.speed,
                'Pressure',
                '${weather.pressure.round()} hPa',
              ),
              _buildDetailItem(
                context,
                Icons.cloud,
                'Cloudiness',
                '${weather.cloudiness}%',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(
      BuildContext context, IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }

  Widget _buildForecastSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '5-Day Forecast',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            height: 100,
            child: Center(
              child: Text(
                'Forecast data will be displayed here',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Information',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Air quality, weather alerts, and other data will be displayed here',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
