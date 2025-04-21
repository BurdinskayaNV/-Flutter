// main_screen_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app2/screens/cubit/main_screen_cubit.dart';
import 'package:my_app2/screens/main_screen.dart';

class MainScreenProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainScreenCubit(),
      child: MainScreen(),
    );
  }
}
