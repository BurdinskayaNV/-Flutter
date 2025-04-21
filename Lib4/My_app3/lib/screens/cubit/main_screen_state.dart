// main_screen_state.dart
part of 'main_screen_cubit.dart';

// Базовый класс состояния
abstract class MainScreenState {}

// Начальное состояние
class MainScreenInitial extends MainScreenState {}

// Состояние обновления
class MainScreenUpdated extends MainScreenState {}
