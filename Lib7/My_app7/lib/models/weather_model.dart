// weather_model.dart - модель данных погоды
class WeatherModel {
  final String city;
  final double temperature;
  final double humidity;
  final double windSpeed;
  final String description;
  final DateTime timestamp;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.description,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'city': city,
        'temperature': temperature,
        'humidity': humidity,
        'windSpeed': windSpeed,
        'description': description,
        'timestamp': timestamp.toIso8601String(),
      };

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        city: json['city'],
        temperature: json['temperature'],
        humidity: json['humidity'],
        windSpeed: json['windSpeed'],
        description: json['description'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}