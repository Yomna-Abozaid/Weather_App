import 'package:flutter/material.dart';
import 'package:untitled35/api_services.dart';
import 'package:untitled35/weather_model.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final ApiService apiService = ApiService();
  late Future<List<WeatherModel>> _weatherFuture;
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _weatherFuture = Future.value([]);
  }

  Future<List<WeatherModel>> getAllWeather(String city) async {
    List<WeatherModel> weather = [];
    final result = await apiService.getAllWeather(city);
    if (result.isNotEmpty && result.containsKey('list')) {
      for (var item in result['list']) {
        weather.add(WeatherModel.fromJson(item));
      }
    }
    return weather;
  }

  void _fetchWeather() {
    final city = _cityController.text;
    if (city.isNotEmpty) {
      setState(() {
        _weatherFuture = getAllWeather(city);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amberAccent, Colors.lightBlue.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _cityController,
                decoration: const InputDecoration(icon: Icon(Icons.search),
                  labelText: 'Enter city',

                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: const Text('Get Weather'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<WeatherModel>>(
                future: _weatherFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No weather data available.'));
                  } else {
                    final weather = snapshot.data!;
                    return ListView.builder(
                      itemCount: weather.length,
                      itemBuilder: (context, index) {
                        final item = weather[index];
                        return ListTile(
                          leading: Image.network('http://openweathermap.org/img/wn/${item.icon}.png'),
                          title: Text(item.description),
                          subtitle: Text(
                            '${item.temperature}°C\n'
                                'Feels like: ${item.feelsLike}°C\n'
                                'Min Temp: ${item.tempMin}°C\n'
                                'Max Temp: ${item.tempMax}°C\n'
                                'Pressure: ${item.pressure} hPa\n'
                                'Humidity: ${item.humidity}%\n'
                                'Visibility: ${item.visibility} m\n'
                                'Wind Speed: ${item.windSpeed} m/s\n'
                                'Wind Direction: ${item.windDeg}°',
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
