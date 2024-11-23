import 'package:flutter/material.dart';
import 'package:cli_mate/screens/home_screen.dart';
import 'package:cli_mate/screens/favorites_screen.dart';
import 'package:cli_mate/screens/splash_screen.dart';

void main() => runApp(const WeatherApp());

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/favorites': (context) => const FavoritesScreen(),
      },
    );
  }
}