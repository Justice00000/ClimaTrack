// ignore_for_file: library_private_types_in_public_api

import 'package:cli_mate/models/weather_model.dart';
import 'package:cli_mate/services/weather_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final WeatherService _weatherService = WeatherService();

  String? _errorMessage;
  Map<String, dynamic>? _weatherData;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _favorites = []; // List to store favorite weather data

  bool _isFavorite = false; // Track if the current weather is favorited

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  Future<void> _searchCityWeather() async {
    final cityName = _controller.text.trim();
    if (cityName.isEmpty) return;

    try {
      final data = await _weatherService.fetchWeather(cityName);
      setState(() {
        _weatherData = data;
        _errorMessage = null;
        _isFavorite = false; // Reset favorite status when new weather is fetched
      });
      _animationController.forward();
    } catch (e) {
      setState(() {
        _errorMessage = 'Unable to fetch weather for "$cityName"';
        _weatherData = null;
      });
      _animationController.reverse();
    }
  }

  void _toggleFavorite() {
    if (_isFavorite) {
      setState(() {
        _favorites.remove(_weatherData); // Remove from favorites if already favorited
        _isFavorite = false;
      });
    } else {
      setState(() {
        _favorites.add(_weatherData!); // Add to favorites
        _isFavorite = true;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          alignment: Alignment.center,
          child: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'CLIMATRACK',
              style: TextStyle(
                fontSize: 28,
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(  // Wrap the entire body with SingleChildScrollView
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: Icon(
                    Icons.wb_sunny,
                    size: 100,
                    color: Colors.lightBlue,
                  ),
                ),
                const SizedBox(height: 20),  // Adjust space before the TextField
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter city name',
                    labelStyle: const TextStyle(color: Colors.blueGrey),
                    filled: true,
                    fillColor: Colors.blue.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search, color: Colors.blue),
                      onPressed: _searchCityWeather,
                    ),
                  ),
                  onSubmitted: (_) => _searchCityWeather(),
                ),
                const SizedBox(height: 20),
                if (_errorMessage != null)
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(_errorMessage!, style: const TextStyle(color: Colors.red, fontSize: 16)),
                  ),
                const SizedBox(height: 20),
                if (_weatherData != null)
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        WeatherWidget(
                          cityName: _weatherData!['name'],
                          temperature: _weatherData!['main']['temp'],
                          description: _weatherData!['weather'][0]['description'],
                        ),
                        IconButton(
                          icon: Icon(
                            _isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: _isFavorite ? Colors.red : Colors.grey,
                            size: 30,
                          ),
                          onPressed: _toggleFavorite,
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
                const Text(
                  'Favorites:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                // Use a limited height container for the list
                Container(
                  height: 300,  // Limit the height of the list to prevent overflow
                  child: ListView.builder(
                    itemCount: _favorites.length,
                    itemBuilder: (context, index) {
                      final favorite = _favorites[index];
                      return ListTile(
                        title: Text(favorite['name']),
                        subtitle: Text('${favorite['main']['temp']}°C - ${favorite['weather'][0]['description']}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove_circle, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _favorites.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}