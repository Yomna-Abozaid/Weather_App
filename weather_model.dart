class WeatherModel {
  final String description;
  final String icon;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final int visibility;
  final double windSpeed;
  final int windDeg;
  final String cityName;
  final String country;

  WeatherModel({
    required this.description,
    required this.icon,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.cityName,
    required this.country,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    final main = json['main'];
    final wind = json['wind'];
    final sys = json['sys'];

    return WeatherModel(
      description: weather['description'] ?? 'No description',
      icon: weather['icon'] ?? '',
      temperature: main['temp']?.toDouble() ?? 0.0,
      feelsLike: main['feels_like']?.toDouble() ?? 0.0,
      tempMin: main['temp_min']?.toDouble() ?? 0.0,
      tempMax: main['temp_max']?.toDouble() ?? 0.0,
      pressure: main['pressure'] ?? 0,
      humidity: main['humidity'] ?? 0,
      visibility: json['visibility'] ?? 0,
      windSpeed: wind['speed']?.toDouble() ?? 0.0,
      windDeg: wind['deg'] ?? 0,
      cityName: json['name'] ?? 'No city name',
      country: sys['country'] ?? 'No country',
    );
  }
}
