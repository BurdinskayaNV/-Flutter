// history_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app5/screens/cubit/history_cubit.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('История расчётов'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              context.read<HistoryCubit>().clearHistory();
            },
          ),
        ],
      ),
      body: BlocBuilder<HistoryCubit, List<Map<String, dynamic>>>(
        builder: (context, history) {
          return history.isEmpty
              ? Center(child: Text('Нет сохранённых расчётов'))
              : ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    final calc = history[index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Капитал: ${calc['capital']} руб.'),
                            Text('Ставка: ${calc['rate']}%'),
                            Text('Срок: ${calc['time']} лет'),
                            Text('Получено процентов: ${calc['interest'].toStringAsFixed(2)} руб.'),
                            Text('Итоговая сумма: ${calc['totalAmount'].toStringAsFixed(2)} руб.'),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}