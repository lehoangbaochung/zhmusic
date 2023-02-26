import 'package:audio/pages/artist/artist_page.dart';
import 'package:audio/pages/main/main_page.dart';
import 'package:audio/widgets/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:src/exports/entities.dart';

enum AppPages {
  main,
  artist;

  String get path => '/$name';

  /// Pop the top-most route off the [Navigator] that most tightly encloses the given [context].
  static void pop(BuildContext context) => Navigator.pop(context);

  /// Push a [path] onto the stack with an optional [data] object.
  static void push(BuildContext context, String path, [dynamic data]) => context.push(path, extra: data);

  static GoRouter get routerConfig {
    return GoRouter(
      initialLocation: AppPages.main.path,
      routes: [
        GoRoute(
          path: AppPages.main.path,
          builder: (_, __) {
            return BlocProvider(
              create: (_) => MainCubit(),
              child: const MainPage(),
            );
          },
        ),
        GoRoute(
          path: AppPages.artist.path,
          builder: (context, state) {
            return ArtistPage(state.extra as Artist);
          },
        ),
      ],
    );
  }
}
