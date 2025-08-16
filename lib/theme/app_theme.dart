// lib/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';

class AppTheme {
  // A subtle text shadow applied to most text for readability on gradients
  static const List<Shadow> _textShadow = [
    Shadow(
      color: Colors.black38,
      offset: Offset(1, 1),
      blurRadius: 2,
    ),
  ];

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF6A82FB),
      scaffoldBackgroundColor: Colors.transparent,
      fontFamily: GoogleFonts.lato().fontFamily,
      colorScheme: ColorScheme.dark(
        primary: const Color(0xFF6A82FB),
        onPrimary: Colors.white,
        secondary: const Color(0xFF26D0CE),
        onSecondary: Colors.white,
        surface: Colors.transparent,
        onSurface: Colors.white,
        error: const Color(0xFFFF6B6B),
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.lato(
            fontSize: 57,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: _textShadow),
        displayMedium: GoogleFonts.lato(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: _textShadow),
        headlineLarge: GoogleFonts.lato(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: _textShadow),
        headlineMedium: GoogleFonts.lato(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: _textShadow),
        titleLarge: GoogleFonts.lato(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: _textShadow),
        titleMedium: GoogleFonts.lato(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: _textShadow),
        bodyLarge: GoogleFonts.lato(
            fontSize: 16, color: Colors.white, shadows: _textShadow),
        bodyMedium: GoogleFonts.lato(
            fontSize: 14, color: Colors.white70, shadows: _textShadow),
        labelLarge: GoogleFonts.lato(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        labelSmall: GoogleFonts.lato(fontSize: 11, color: Colors.white54),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.15),
        hintStyle: GoogleFonts.lato(color: Colors.white.withOpacity(0.7)),
        labelStyle: GoogleFonts.lato(color: Colors.white.withOpacity(0.9)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide: const BorderSide(color: Color(0xFF26D0CE), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          borderSide:
              BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6A82FB),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle:
              GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xFF26D0CE);
          }
          return Colors.white;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xFF26D0CE).withOpacity(0.5);
          }
          return Colors.white.withOpacity(0.3);
        }),
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withOpacity(0.15),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }

  // Light theme for future use
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF6A82FB),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: GoogleFonts.lato().fontFamily,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFF6A82FB),
        onPrimary: Colors.white,
        secondary: Color(0xFF26D0CE),
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black87,
        error: Color(0xFFD32F2F),
        onError: Colors.white,
      ),
    );
  }
}
