// main_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app5/screens/cubit/history_cubit.dart';
import 'package:my_app5/screens/cubit/main_screen_cubit.dart';
import 'package:my_app5/screens/cubit/main_screen_state.dart';
import 'package:my_app5/screens/history_screen.dart';

class MainScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenCubit, MainScreenState>(
      builder: (context, state) {
        final cubit = context.read<MainScreenCubit>();
        return Scaffold(
          appBar: AppBar(
            title: Text('Калькулятор простых процентов'),
            leading: IconButton(
              icon: Icon(Icons.history),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => HistoryCubit(),
                      child: HistoryScreen(),
                    ),
                  ),
                );
              },
            ),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: cubit.capitalController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Исходный капитал'),
                    onChanged: (value) => cubit.updateCapital(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите исходный капитал';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: cubit.rateController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Ставка процентов (%)'),
                    onChanged: (value) => cubit.updateRate(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите ставку процентов';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: cubit.timeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Срок начисления (лет)'),
                    onChanged: (value) => cubit.updateTime(value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста, введите срок начисления';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: state.agreed,
                        onChanged: (value) {
                          cubit.updateAgreed(value ?? false);
                        },
                      ),
                      Text('Согласен на обработку данных'),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (!state.agreed) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Вы должны согласиться с условиями обработки персональных данных.')),
                          );
                        } else {
                          cubit.calculate(context);
                        }
                      }
                    },
                    child: Text('Рассчитать'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}