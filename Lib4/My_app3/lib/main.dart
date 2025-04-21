// main.dart
import 'package:flutter/material.dart';
import 'package:my_app2/screens/main_screen_provider.dart'; // Импортируем провайдер экрана

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор простых процентов', // Название приложения
      theme: ThemeData(
        primarySwatch: Colors.blue, // Основная цветовая схема
      ),
      home: MainScreenProvider(), // Главный экран приложения
    );
  }
}
