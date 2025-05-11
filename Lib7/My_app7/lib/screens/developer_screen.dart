// developer_screen.dart - экран с информацией о разработчике
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';

class DeveloperScreen extends StatelessWidget {
  final String articleUrl = 'https://www.windy.com/';

  const DeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Информация о разработчике'),
         // Добавляем кнопку "Назад" с иконкой back.png в AppBar
        leading: IconButton(
          icon: Image.asset('assets/back.png'), // Используем изображение back.png
          onPressed: () {
            Navigator.of(context).pop(); // Возвращаемся на предыдущий экран
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Имя: Бурдинская Наталья', style: TextStyle(fontSize: 20)),
            Text('Группа: ВМК-22', style: TextStyle(fontSize: 20)),
            Text('Электронная почта: Burdinskaya@111.ru', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final uri = Uri.parse(articleUrl);
                try {
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(
                      uri,
                      mode: LaunchMode.externalApplication, // Открывать в браузере
                    );
                    if (kDebugMode) {
                      debugPrint('Successfully launched URL: $articleUrl');
                    }
                  } else {
                    if (kDebugMode) {
                      debugPrint('Cannot launch URL: $articleUrl');
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ошибка: сайт не открывактся.')),
                    );
                  }
                } catch (e) {
                  if (kDebugMode) {
                    debugPrint('Error launching URL: $e');
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ошибка: сайт не открывактся. $e')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 60), // Задаем минимальные размеры кнопки (ширина, высота)
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12) // Добавляем скругление углов
                  ),
                  padding: EdgeInsets.all(16) // Внутренние отступы
              ),
              child: Row( // Используем Row для размещения иконки и текста
                mainAxisSize: MainAxisSize.min, // Выравниваем элементы по центру
                children: [
                  Image.asset('assets/wind.png', width: 30, height: 30),
                  SizedBox(width: 8), // Добавляем отступ между иконкой и текстом
                  Text('Карта ветров', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}