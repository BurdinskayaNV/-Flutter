// history_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryCubit extends Cubit<List<Map<String, dynamic>>> {
  HistoryCubit() : super([]) {
    loadCalculations();
  }

  Future<void> loadCalculations() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? historyStrings = prefs.getStringList('history');
    if (historyStrings != null) {
      List<Map<String, dynamic>> history = historyStrings.map((string) {
        List<String> values = string.split(',');
        return {
          'capital': double.parse(values[0]),
          'rate': double.parse(values[1]),
          'time': double.parse(values[2]),
          'interest': double.parse(values[3]),
          'total_amount': double.parse(values[4]),
          'date': values[5]
        };
      }).toList();
      emit(history);
    } else {
      emit([]);
    }
  }
}