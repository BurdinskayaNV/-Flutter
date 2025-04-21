// main_screen.dart - исправленный код
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app2/screens/cubit/main_screen_cubit.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenCubit, MainScreenState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<MainScreenCubit>(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('Калькулятор простых процентов'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: cubit.capitalController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Исходный капитал'),
                ),
                TextFormField(
                  controller: cubit.rateController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Ставка процентов (%)'),
                ),
                TextFormField(
                  controller: cubit.timeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Срок начисления (лет)'),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: cubit.agreed, // Используем геттер для получения состояния
                      onChanged: (value) {
                        cubit.updateAgreement(value ?? false); // Обновляем состояние через метод
                      },
                    ),
                    Text('Согласен на обработку данных'),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    cubit.calculate(context);
                  },
                  child: Text('Рассчитать'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Экран результатов 
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