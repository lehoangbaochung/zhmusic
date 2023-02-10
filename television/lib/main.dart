import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/repositories.dart';

import 'pages/main/main_page.dart';

void main() async {
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  await musicCollection.ensureInitialized();
  final state = await MainState.initialize(audioOnly: true);
  runApp(
    MaterialApp(
      home: BlocProvider(
        create: (_) => MainCubit(state),
        child: BlocBuilder<MainCubit, MainState>(
          builder: (context, state) {
            return const MainPage();
          },
        ),
      ),
      title: MusicType.television.title,
      debugShowCheckedModeBanner: false,
      scrollBehavior: const ScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
    ),
  );
  FlutterNativeSplash.remove();
}
