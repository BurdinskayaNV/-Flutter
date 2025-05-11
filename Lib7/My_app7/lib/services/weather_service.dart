// weather_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app7/models/weather_model.dart';

class WeatherService {
  final String apiKey = 'AK8MoMl1KfT8sDQfpijpR3ztFimA5TrU'; 

  // Базовые URL для запросов к AccuWeather API
  final String locationUrl = 'http://dataservice.accuweather.com/locations/v1/cities/search';
  final String weatherUrl = 'http://dataservice.accuweather.com/currentconditions/v1/';

  // Метод для получения погоды по названию города
  Future<WeatherModel> fetchWeather(String city) async {
    try {
      // Шаг 1: Получаем ключ локации (locationKey) по названию города
      final locationResponse = await http.get(Uri.parse(
          '$locationUrl?q=$city&apikey=$apiKey'));

      if (locationResponse.statusCode == 200) {
        final locationData = jsonDecode(locationResponse.body);

        // Проверяем, что список локаций не пустой
        if (locationData.isEmpty) {
          throw Exception('Город не найден');
        }

        // Извлекаем locationKey из первого результата
        final String locationKey = locationData[0]['Key'];

        // Шаг 2: Получаем текущую погоду по locationKey
        final weatherResponse = await http.get(Uri.parse(
            '$weatherUrl$locationKey?apikey=$apiKey&language=ru-RU&details=true'));

        if (weatherResponse.statusCode == 200) {
          final weatherData = jsonDecode(weatherResponse.body);

          // Парсим данные и возвращаем модель погоды
          return WeatherModel(
            city: locationData[0]['LocalizedName'],
            temperature: weatherData[0]['Temperature']['Metric']['Value'].toDouble(),
            humidity: weatherData[0]['RelativeHumidity']?.toDouble() ?? 0.0,
            windSpeed: weatherData[0]['Wind']['Speed']['Metric']['Value'].toDouble(),
            description: weatherData[0]['WeatherText'],
            timestamp: DateTime.now(),
          );
        } else {
          throw Exception('Ошибка загрузки данных о погоде: ${weatherResponse.statusCode}');
        }
      } else {
        throw Exception('Ошибка поиска города: ${locationResponse.statusCode}');
      }
    } catch (e) {
      // Ловим сетевые ошибки или ошибки парсинга
      throw Exception('Ошибка сети или данных: $e');
    }
  }
}
