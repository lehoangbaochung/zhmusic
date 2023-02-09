import 'package:audio/app/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/repositories.dart';

import 'app/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await musicCollection.ensureInitialized();
  runApp(
    BlocProvider(
      create: (_) => AppCubit(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppPages.routerConfig,
          );
        },
      ),
    ),
  );
}
