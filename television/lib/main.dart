import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/repositories.dart';

import '/app/app_storage.dart';
import '/pages/main/main_page.dart';

void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  // init local storage
  await musicStorage.ensureInitialized();
  await appStorage.ensureInitialized();
  await musicService.rotateScreen();
  // allow play background
  await JustAudioBackground.init(
    androidNotificationOngoing: true,
    androidNotificationChannelId: MusicType.television.packageName,
    androidNotificationChannelName: MusicType.television.title,
  );
  runApp(
    BlocProvider(
      create: (_) => MainCubit(),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Shortcuts(
            shortcuts: {
              LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
            },
            child: MaterialApp(
              home: const MainPage(),
              title: MusicType.television.title,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.green,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                brightness: state.themeMode ? Brightness.light : Brightness.dark,
              ),
              scrollBehavior: const ScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.stylus,
                  PointerDeviceKind.trackpad, 
                  PointerDeviceKind.invertedStylus,
                  PointerDeviceKind.unknown,
                },
              ),
            ),
          );
        },
      ),
    ),
  );
  FlutterNativeSplash.remove();
}
