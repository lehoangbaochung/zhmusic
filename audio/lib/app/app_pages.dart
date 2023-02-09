import 'package:audio/pages/home_page.dart';
import 'package:audio/pages/player_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppPages {
  home,
  player;

  String get path => '/$name';

  /// Pop the top-most route off the [Navigator] that most tightly encloses the given [context].
  static void pop(BuildContext context) => Navigator.pop(context);

  /// Push a [path] onto the stack with an optional [data] object.
  static void push(BuildContext context, String path, [dynamic data]) => context.push(path, extra: data);

  static GoRouter get routerConfig {
    return GoRouter(
      initialLocation: AppPages.home.path,
      routes: [
        GoRoute(
          path: AppPages.home.path,
          builder: (_, __) => const HomePage(),
        ),
        GoRoute(
          path: AppPages.player.path,
          builder: (_, state) => const PlayerPage(),
        ),
      ],
    );
  }
}
