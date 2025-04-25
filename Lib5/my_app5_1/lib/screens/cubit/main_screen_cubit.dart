// main_screen_cubit.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app5/screens/cubit/main_screen_state.dart';
import 'package:my_app5/screens/cubit/history_repository.dart';
import 'package:my_app5/screens/result_screen.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  // Используем существующий экземпляр синглтона
  final HistoryRepository _historyRepository = HistoryRepository();

  MainScreenCubit() : super(MainScreenInitial()) {
    _init();
  }

  double _capital = 0;
  double _rate = 0;
  double _time = 0;
  bool _agreed = false;

  final TextEditingController capitalController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  Future _init() async {
    // Теперь init() вызывается у правильного экземпляра
    await _historyRepository.init();
  }

  void updateCapital(String capital) {
    _capital = double.tryParse(capital) ?? 0;
    emit(MainScreenUpdated(capital: _capital, rate: _rate, time: _time, agreed: _agreed));
  }

  void updateRate(String rate) {
    _rate = double.tryParse(rate) ?? 0;
    emit(MainScreenUpdated(capital: _capital, rate: _rate, time: _time, agreed: _agreed));
  }

  void updateTime(String time) {
    _time = double.tryParse(time) ?? 0;
    emit(MainScreenUpdated(capital: _capital, rate: _rate, time: _time, agreed: _agreed));
  }

  void updateAgreed(bool value) {
    _agreed = value;
    emit(MainScreenUpdated(capital: _capital, rate: _rate, time: _time, agreed: _agreed));
  }

  Future calculate(BuildContext context) async {
    if (_validateInputs()) {
      final capital = double.parse(capitalController.text);
      final rate = double.parse(rateController.text);
      final time = double.parse(timeController.text);
      final interest = (capital * rate * time) / 100;
      final totalAmount = capital + interest;

      await _historyRepository.saveCalculation(capital, rate, time, interest, totalAmount);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            capital: capital,
            rate: rate,
            time: time,
            interest: interest,
            totalAmount: totalAmount,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Проверьте введенные данные')),
      );
    }
  }

  bool _validateInputs() {
    return double.tryParse(capitalController.text) != null &&
        double.tryParse(rateController.text) != null &&
        double.tryParse(timeController.text) != null &&
        _agreed;
  }
}
