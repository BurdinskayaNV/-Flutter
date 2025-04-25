// nasa_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../requests/api.dart';

abstract class MarsRoverState extends Equatable {
  const MarsRoverState();
  @override List<Object> get props => [];
}

class MarsRoverLoading extends MarsRoverState {}
class MarsRoverLoaded extends MarsRoverState {
  final List<Map<String, dynamic>> photos;
  const MarsRoverLoaded(this.photos);
  @override List<Object> get props => [photos];
}
class MarsRoverError extends MarsRoverState {
  final String message;
  const MarsRoverError(this.message);
  @override List<Object> get props => [message];
}

class MarsRoverCubit extends Cubit<MarsRoverState> {
  MarsRoverCubit() : super(MarsRoverLoading());

  Future<void> loadPhotos(int sol) async {
    emit(MarsRoverLoading());
    try {
      final photos = await NasaApi.getMarsPhotos(sol);
      emit(MarsRoverLoaded(photos));
    } catch (e) {
      emit(MarsRoverError(e.toString()));
    }
  }
}