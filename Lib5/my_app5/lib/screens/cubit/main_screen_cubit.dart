// main_screen_cubit.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart'; // Для работы с датами
import 'package:my_app5/screens/cubit/main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenInitial());

  double _capital = 0;
  double _rate = 0;
  double _time = 0;

  final capitalController = TextEditingController();
  final rateController = TextEditingController();
  final timeController = TextEditingController();

  bool _agreed = false;

  bool get agreed => _agreed;

  void updateCapital(double capital) {
    _capital = capital;
    emit(MainScreenUpdated(capital: _capital, rate: _rate, time: _time, agreed: _agreed));
  }

  void updateRate(double rate) {
    _rate = rate;
    emit(MainScreenUpdated(capital: _capital, rate: _rate, time: _time, agreed: _agreed));
  }

  void updateTime(double time) {
    _time = time;
    emit(MainScreenUpdated(capital: _capital, rate: _rate, time: _time, agreed: _agreed));
  }

  void updateAgreed(bool value) {
    _agreed = value;
    emit(MainScreenUpdated(capital: _capital, rate: _rate, time: _time, agreed: _agreed));
  }

  Future<void> _saveToHistory(double capital, double rate, double time, double interest, double totalAmount) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> historyStrings = prefs.getStringList('history') ?? [];
    String now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    historyStrings.add('$capital,$rate,$time,$interest,$totalAmount,$now');
    await prefs.setStringList('history', historyStrings);
  }

  void calculate(BuildContext context) {
    if (_validateInputs()) {
      final capital = double.parse(capitalController.text);
      final rate = double.parse(rateController.text);
      final time = double.parse(timeController.text);
      final interest = (capital * rate * time) / 100;
      final totalAmount = capital + interest;

      _saveToHistory(capital, rate, time, interest, totalAmount);

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