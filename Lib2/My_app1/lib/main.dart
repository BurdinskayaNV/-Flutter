import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Лабораторная работа №2.\nВыполнила: Бурдинская Наталья ВМК-22'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

// Главный виджет, который формирует содержимое экрана
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Распределение иконок равномерно
          children: [
            Icon(Icons.star, size: 40, color: Colors.amber),
            Icon(Icons.favorite, size: 40, color: Colors.red),
            Icon(Icons.thumb_up, size: 40, color: Colors.blue),
          ],
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.music_note, size: 40, color: Colors.purple),
            Icon(Icons.movie, size: 40, color: Colors.teal),
            Icon(Icons.book, size: 40, color: Colors.orange),
          ],
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.directions_car, size: 40, color: Colors.green),
            Icon(Icons.flight, size: 40, color: Colors.indigo),
            Icon(Icons.directions_bike, size: 40, color: Colors.brown),
          ],
        ),
      ],
    ),
    );
  }
}
