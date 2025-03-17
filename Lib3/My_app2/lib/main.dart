import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SimpleInterestCalculator(),
    );
  }
}

// Первый экран - форма для ввода данных
class SimpleInterestCalculator extends StatefulWidget {
  @override
  _SimpleInterestCalculatorState createState() =>
      _SimpleInterestCalculatorState();
}

class _SimpleInterestCalculatorState extends State<SimpleInterestCalculator> {
  // Контроллеры для полей ввода
  final _capitalController = TextEditingController();
  final _rateController = TextEditingController();
  final _timeController = TextEditingController();

  // Переменная для состояния чекбокса
  bool _agreed = false;

  // Ключ для формы
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Лабораторная работа №3. Калькулятор простых процентов\nВыполнила: Бурдинская Наталья ВМК-22'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Поле для ввода капитала
              TextFormField(
                controller: _capitalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Исходный капитал'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите сумму капитала';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Введите корректное числовое значение';
                  }
                  return null;
                },
              ),
              // Поле для ввода ставки
              TextFormField(
                controller: _rateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Ставка процентов (%)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите ставку процентов';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Введите корректное числовое значение';
                  }
                  return null;
                },
              ),
              // Поле для ввода времени
              TextFormField(
                controller: _timeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Срок начисления (лет)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Пожалуйста, введите срок начисления';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Введите корректное числовое значение';
                  }
                  return null;
                },
              ),
              // Чекбокс согласия
              Row(
                children: [
                  Checkbox(
                    value: _agreed,
                    onChanged: (value) {
                      setState(() {
                        _agreed = value ?? false;
                      });
                    },
                  ),
                  Text('Согласен на обработку данных'),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Валидация формы
                  if (_formKey.currentState!.validate() && _agreed) {
                    // Получаем значения из полей
                    double capital = double.parse(_capitalController.text);
                    double rate = double.parse(_rateController.text);
                    double time = double.parse(_timeController.text);

                    // Переходим на второй экран с передачей данных
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
                  } else if (!_agreed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Необходимо согласиться на обработку данных')),
                    );
                  }
                },
                child: Text('Рассчитать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Второй экран - результаты расчета
class ResultScreen extends StatelessWidget {
  final double capital;
  final double rate;
  final double time;

  const ResultScreen({
    required this.capital,
    required this.rate,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    // Расчет простых процентов
    double interest = (capital * rate * time) / 100;
    double totalAmount = capital + interest;

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
