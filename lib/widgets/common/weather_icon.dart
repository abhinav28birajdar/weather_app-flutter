// lib/widgets/common/weather_icon.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../models/weather/weather_condition.dart';

class WeatherIcon extends StatelessWidget {
  final WeatherCondition condition;
  final double size;
  final bool animate;

  const WeatherIcon({
    super.key,
    required this.condition,
    this.size = 100,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Lottie.asset(
        condition.iconPath,
        width: size,
        height: size,
        fit: BoxFit.contain,
        animate: animate,
        repeat: animate,
      ),
    );
  }
}

class StaticWeatherIcon extends StatelessWidget {
  final WeatherCondition condition;
  final double size;
  final Color? color;

  const StaticWeatherIcon({
    super.key,
    required this.condition,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      _getIconData(condition),
      size: size,
      color: color ?? Theme.of(context).iconTheme.color,
    );
  }

  IconData _getIconData(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.clear:
        return Icons.wb_sunny;
      case WeatherCondition.clouds:
        return Icons.cloud;
      case WeatherCondition.rain:
        return Icons.grain;
      case WeatherCondition.drizzle:
        return Icons.grain;
      case WeatherCondition.snow:
        return Icons.ac_unit;
      case WeatherCondition.thunderstorm:
        return Icons.flash_on;
      case WeatherCondition.mist:
      case WeatherCondition.fog:
        return Icons.cloud;
      case WeatherCondition.smoke:
      case WeatherCondition.haze:
      case WeatherCondition.dust:
      case WeatherCondition.sand:
      case WeatherCondition.ash:
        return Icons.blur_on;
      case WeatherCondition.squall:
      case WeatherCondition.tornado:
        return Icons.tornado;
      default:
        return Icons.help_outline;
    }
  }
}
