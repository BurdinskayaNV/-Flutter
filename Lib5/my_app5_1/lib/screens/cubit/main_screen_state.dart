// main_screen_state.dart
abstract class MainScreenState {
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