import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  final String cityName;
  final double temperature;
  final String description;

  const WeatherWidget({
    super.key,
    required this.cityName,
    required this.temperature,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(cityName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Text('${temperature.toStringAsFixed(1)}°C'),
      ),
    );
  }
}