// main_screen_state.dart
import 'package:flutter/material.dart';
import 'package:my_app5/screens/cubit/main_screen_cubit.dart';

abstract class MainScreenState {
  double get capital => 0;
  double get rate => 0;
  double get time => 0;
  bool get agreed => false;
}

class MainScreenInitial extends MainScreenState {}

class MainScreenUpdated extends MainScreenState {
  final double capital;
  final double rate;
  final double time;
  final bool agreed;

  MainScreenUpdated({
    required this.capital,
    required this.rate,
    required this.time,
    required this.agreed,
  });
}

// result_screen.dart
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
            Text('Простые проценты: ${interest.toStringAsFixed(2)}'),
            SizedBox(height: 10),
            Text('Общая сумма: ${totalAmount.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}