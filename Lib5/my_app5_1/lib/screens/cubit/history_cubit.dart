// history_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app5/screens/cubit/history_repository.dart';

class HistoryCubit extends Cubit<List<Map<String, dynamic>>> {
  final HistoryRepository _repository = HistoryRepository();

  HistoryCubit() : super([]) {
    _init(); // Инициализация состояния при создании кубита
  }

  Future<void> _init() async {
    await _repository.init(); // Инициализация базы данных
    loadCalculations(); // Загрузка истории расчетов
  }

  Future<void> loadCalculations() async {
    final history = await _repository.getHistory(); // Получение истории из репозитория
    emit(history); // Обновление состояния
  }

  Future<void> addCalculation(double capital, double rate, double time, double interest, double totalAmount) async {
    await _repository.saveCalculation(capital, rate, time, interest, totalAmount); // Сохранение нового расчета
    loadCalculations(); // Перезагрузка истории
  }

  Future<void> clearHistory() async {
    await _repository.clearHistory(); // Очистка истории в репозитории
    loadCalculations(); // Перезагрузка состояния
  }
}
