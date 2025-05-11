// storage_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app7/models/weather_model.dart';

class StorageService {
  static const String weatherHistoryKey = 'weather_history';

  Future<void> saveWeather(WeatherModel weather) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getWeatherHistory();
    history.add(weather);
    final encoded = history.map((w) => jsonEncode(w.toJson())).toList();
    await prefs.setStringList(weatherHistoryKey, encoded);
  }

  Future<List<WeatherModel>> getWeatherHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getStringList(weatherHistoryKey) ?? [];
    return encoded
        .map((e) => WeatherModel.fromJson(jsonDecode(e)))
        .toList()
        .reversed
        .toList();
  }
}