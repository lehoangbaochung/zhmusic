import 'package:audio/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppPages {
  main,
  player;

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
          builder: (_, __) => const MainPage(),
        ),
        // GoRoute(
        //   path: AppPages.player.path,
        //   builder: (_, state) => const PlayerPage(),
        // ),
      ],
    );
  }
}
