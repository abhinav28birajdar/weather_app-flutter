import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'screens/weather/weather_screen.dart';
// import 'screens/location_management_screen.dart';
// import 'screens/settings_screen.dart';
// import 'screens/weather_charts_screen.dart';
// import 'screens/weather_map_screen.dart';
// import 'screens/about_screen.dart';
import 'theme/app_theme.dart';
import 'services/notification_service.dart';

void main() async {
  // Ensure Flutter widgets are initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize notification service
  await NotificationService.initialize();

  runApp(
    // ProviderScope is required for Riverpod to work
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configure go_router for navigation
    final GoRouter router = GoRouter(
      initialLocation: '/', // Starting path
      routes: <RouteBase>[
        // Main Weather Screen Route
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const WeatherScreen();
          },
        ),
        // Additional routes will be added as new screens are implemented
      ],
      // Optional: Error handling for unknown routes
      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text(
            'Page not found: ${state.uri}',
            style: const TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    return MaterialApp.router(
      routerConfig: router, // Connects go_router to MaterialApp
      title: 'NimbusWeather',
      theme: AppTheme.darkTheme, // Apply your custom dark theme
      debugShowCheckedModeBanner: false, // Hide the debug banner
    );
  }
}
