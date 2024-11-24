import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../weather_service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final WeatherService _weatherService = WeatherService('880d4d21260d1b76c569ac6b1afcbca2');
  Weather? _weather;

 fetchWeather() async {
    try {
      String cityName = await _weatherService.getCurrentCity();
      Weather weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }
 String getWeatherAnimation(String? mainCondition) {
  if (mainCondition == null) return 'assets/rain.json';
  switch (mainCondition.toLowerCase()) {
    case 'cloud':
    case 'mist':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'fog':
      return 'assets/cloud.json';
    case 'rain':
    case 'drizzle':
    case 'shower rain':
      return 'assets/rain.json';
    case 'clear':
      return 'assets/sun.json';
    case 'thunderstorm':
    case 'lightning':
      return 'assets/light.json';
    default:
      return 'assets/cloud.json'; // Default animation if no match
  }
}

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _weather == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _weather?.cityName ?? "Loading city.."),
                    
                  Lottie.assets('assets/cloud.json'),
                  Text(
                    '${_weather?.temperature?.round() ?? '--'}°C',
                    style: const TextStyle(fontSize: 48),
                  ),
                ],
              ),
      ),
    );
  }
}

class Lottie {
  static assets(String s) {}
}
