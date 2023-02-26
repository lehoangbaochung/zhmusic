import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/repositories.dart';

import 'app/app_cubit.dart';
import 'app/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await musicStorage.ensureInitialized();
  runApp(
    RepositoryProvider(
      create: (_) => AppCubit(),
      child: MaterialApp.router(
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: AppPages.routerConfig,
      ),
    ),
  );
}
