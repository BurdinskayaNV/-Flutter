// result_screen.dart
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double capital;
  final double rate;
  final double time;
  final double interest;
  final double totalAmount;

  const ResultScreen({
    required this.capital,
    required this.rate,
    required this.time,
    required this.interest,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Результаты расчета'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Простые проценты: ${interest.toStringAsFixed(2)} руб.'),
            Text('Общая сумма: ${totalAmount.toStringAsFixed(2)} руб.'),
          ],
        ),
      ),
    );
  }
}