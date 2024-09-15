import 'package:flutter/material.dart';
import 'package:untitled35/api_services.dart';
import 'package:untitled35/screen1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Fetch weather data (or perform other async initialization tasks)
  try {
    ApiService apiService = ApiService();
    final weatherData = await apiService.getAllWeather('Cairo');
    print('Weather data fetched: $weatherData');
  } catch (e) {
    print('Error fetching weather data: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Screen1()
    );
  }
}
