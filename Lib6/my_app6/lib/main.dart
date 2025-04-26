// main.dart # Точка входа
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/nasa_photos_screen.dart';
import 'cubit/nasa_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => MarsRoverCubit()..loadPhotos(100),
        child: const MarsRoverPhotosScreen(),
      ),
    );
  }
}