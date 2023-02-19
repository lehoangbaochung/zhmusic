import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:src/exports/repositories.dart';

import '/app/app_pages.dart';

void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  await musicStorage.ensureInitialized();
  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppPages.routerConfig,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
    ),
  );
  FlutterNativeSplash.remove();
}
