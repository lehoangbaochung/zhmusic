import 'package:audio/app/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/widgets.dart';

extension BuildContextX on BuildContext {
  static const designWidth = 390;
  static const designHeight = 844;

  double getWidth(double height) => mediaHeight * height / designWidth;
  double getHeight(double height) => mediaHeight * height / designHeight;

  AppCubit get appCubit => read<AppCubit>();
  AppState get appState => watch<AppCubit>().state;
}
