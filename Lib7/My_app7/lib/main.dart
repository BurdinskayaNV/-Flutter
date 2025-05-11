// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app7/cubit/weather_cubit.dart';
import 'package:my_app7/screens/weather_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(),
      child: MaterialApp(
        title: 'Данные об актуальной погоде',
        theme: ThemeData(primarySwatch: Colors.blue),
                home: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                // Добавляем иконку слева от заголовка
                Image.asset(
                  'assets/weather.png', // Путь к иконке
                  width: 40,           // Задаем ширину
                  height: 40,          // Задаем высоту
                ),
                SizedBox(width: 8),   // Добавляем отступ
                Text('Погода'),       // Основной текст заголовка
              ],
            ),
          ),
          body: WeatherScreen(),     // Основной экран приложения
        ),
        //home: WeatherScreen(),
      ),
    );
  }
}