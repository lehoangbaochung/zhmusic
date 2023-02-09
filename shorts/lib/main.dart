import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/repositories.dart';
import 'package:src/exports/widgets.dart';

import '/app/app_colors.dart';
import '/app/app_pages.dart';

void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  await musicCollection.ensureInitialized();
  runApp(
    MaterialApp.router(
      title: MusicType.short.title,
      debugShowCheckedModeBanner: false,
      routerConfig: AppPages.routerConfig,
      theme: ThemeData(
        primarySwatch: AppColors.primaryColor.toMaterialColor(),
      ),
    ),
  );
  FlutterNativeSplash.remove();
}
