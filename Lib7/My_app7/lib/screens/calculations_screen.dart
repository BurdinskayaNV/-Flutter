// calculations_screen.dart - экран расчёта скорости ветра
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app7/models/weather_model.dart';

class WindCalculationScreen extends StatefulWidget {
  final WeatherModel? initialWeather;

  const WindCalculationScreen({super.key, this.initialWeather});

  @override
  _WindCalculationScreenState createState() => _WindCalculationScreenState();
}

class _WindCalculationScreenState extends State<WindCalculationScreen> {
  double _windSpeed = 0.0;
  bool _isMetersPerSecond = true;
  List<String> _history = [];
  final String _historyKey = 'wind_speed_history'; // Ключ для SharedPreferences

  @override
  void initState() {
    super.initState();
    _loadHistory(); // Загрузка истории при инициализации
    if (widget.initialWeather != null) {
      _windSpeed = widget.initialWeather!.windSpeed;
    }
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _history = prefs.getStringList(_historyKey) ?? [];
    });
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_historyKey, _history);
  }

  void _addToHistory(String entry) {
    setState(() {
      _history.insert(0, entry); // Добавляем запись в начало списка
      if (_history.length > 10) {
        _history.removeLast(); // Ограничиваем историю до 10 записей
      }
    });
    _saveHistory(); // Сохраняем обновленную историю
  }

  void _convertWindSpeed() {
    setState(() {
      if (_isMetersPerSecond) {
        _windSpeed *= 3.6; // Преобразование м/с в км/ч
      } else {
        _windSpeed /= 3.6; // Преобразование км/ч в м/с
      }
      _isMetersPerSecond = !_isMetersPerSecond;
      String unit = _isMetersPerSecond ? 'м/с' : 'км/ч';
      _addToHistory('${_windSpeed.toStringAsFixed(2)} $unit');
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Расчет скорости ветра'),
          leading: IconButton(
            icon: Image.asset('assets/back.png'),
            onPressed: () {
              Navigator.pop(context); // Возврат на предыдущий экран
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    _windSpeed = double.tryParse(value) ?? 0.0;
                  });
                },
                decoration: const InputDecoration(labelText: 'Введите скорость ветра'),
              ),
              ElevatedButton(
                onPressed: _convertWindSpeed,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 60), // Задаем минимальные размеры кнопки (ширина, высота)
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12) // Добавляем скругление углов
                  ),
                  padding: EdgeInsets.all(16) // Внутренние отступы
                ),
                child: Text(_isMetersPerSecond ? 'Перевести в км/ч' : 'Перевести в м/с', style: TextStyle(fontSize: 20)),
              ),
              Text(
                '   ', style: TextStyle(fontSize: 20)
              ),
              Text(
                'Скорость ветра: ${_windSpeed.toStringAsFixed(2)} ${_isMetersPerSecond ? 'м/с' : 'км/ч'}',
              ),
              const SizedBox(height: 20),
              const Text('История вычислений:', style: TextStyle(fontSize: 18)),
              Expanded(
                child: ListView.builder(
                  itemCount: _history.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_history[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}