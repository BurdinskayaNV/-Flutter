// weather_screen.dart - главный экран
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app7/cubit/weather_cubit.dart';
import 'package:my_app7/models/weather_model.dart';
import 'package:my_app7/screens/calculations_screen.dart';
import 'package:my_app7/screens/developer_screen.dart';

class WeatherScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Данные об актуальной погоде'),
        actions: [
          IconButton(
            icon: Image.asset('assets/person.png', width: 40, height: 40),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DeveloperScreen()),
              );
            },
          ),
          IconButton(
            icon: Image.asset('assets/calculate.png', width: 40, height: 40),
            onPressed: () {
              final state = context.read<WeatherCubit>().state;
              WeatherModel? currentWeather;
              if (state is WeatherLoaded && state.currentWeather != null) {
                currentWeather = state.currentWeather;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WindCalculationScreen(
                    initialWeather: currentWeather,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocConsumer<WeatherCubit, WeatherState>(
    listener: (context, state) {
      if (state is WeatherError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
    },
    builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Введите название города',
                suffixIcon: IconButton(
                  icon: Image.asset('assets/search.png', width: 40, height: 40),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      context.read<WeatherCubit>().fetchWeather(_controller.text);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (state is WeatherLoading)
              const CircularProgressIndicator()
            else if (state is WeatherLoaded && state.currentWeather != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Выравнивание текста
                children: [
                  Text(
                    'Погода в ${state.currentWeather!.city}',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text('Температура: ${state.currentWeather!.temperature.toStringAsFixed(1)}°C'),
                  Text('Влажность: ${state.currentWeather!.humidity.toInt()}%'),
                  Text('Скорость ветра: ${state.currentWeather!.windSpeed.toStringAsFixed(1)} м/с'),
                  Text('Описание: ${state.currentWeather!.description}'),
                ],
              )
            else if (state is WeatherError)
              Text('Ошибка: ${state.message}', style: TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            const Text('История', style: TextStyle(fontSize: 20)),
            Expanded(
              child: ListView.builder(
                itemCount: state is WeatherLoaded ? state.history.length : 0,
                itemBuilder: (context, index) {
                  if (state is! WeatherLoaded) return Container(); // Защита от ошибок состояния

                  final weather = state.history[index];
                  return ListTile(
                    title: Text('${weather.city} - ${weather.description}'),
                    subtitle: Text(
                      '${weather.temperature.toStringAsFixed(1)}°C, ${weather.timestamp}',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    },
  ),
    );
  }
}