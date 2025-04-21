// main_screen_cubit.dart - исправленный код

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app2/screens/main_screen.dart';

// Состояния экрана
part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenInitial());

  // Контроллеры для полей ввода
  final capitalController = TextEditingController();
  final rateController = TextEditingController();
  final timeController = TextEditingController();

  bool _agreed = false; // Добавляем приватное поле для состояния согласия

  // Геттер для получения значения согласия
  bool get agreed => _agreed;

  // Обновление состояния чекбокса
  void updateAgreement(bool value) {
    _agreed = value; // Обновляем значение согласия
    emit(MainScreenUpdated()); // Уведомляем UI об изменении состояния
  }

  // Валидация и расчет
  void calculate(BuildContext context) {
    if (_validateInputs()) {
      final capital = double.parse(capitalController.text);
      final rate = double.parse(rateController.text);
      final time = double.parse(timeController.text);

      // Переход на экран результатов
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            capital: capital,
            rate: rate,
            time: time,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Проверьте введенные данные')),
      );
    }
  }

  // Валидация полей
  bool _validateInputs() {
    return double.tryParse(capitalController.text) != null &&
           double.tryParse(rateController.text) != null &&
           double.tryParse(timeController.text) != null &&
           _agreed; // Используем приватное поле согласия
  }
}