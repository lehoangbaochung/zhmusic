import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:src/exports/entities.dart';

import '/pages/artist_page.dart';
import '/pages/audio_page.dart';
import '/pages/main_page.dart';
import '/pages/short_page.dart';
import '/pages/settings_page.dart';

export '/pages/search_page.dart';

enum AppPages {
  main,
  audio,
  artist,
  short,
  settings;

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
        GoRoute(
          path: AppPages.settings.path,
          builder: (_, __) => const SettingsPage(),
        ),
        GoRoute(
          path: AppPages.audio.path,
          builder: (_, state) => AudioPage(state.extra as Audio),
        ),
        GoRoute(
          path: AppPages.artist.path,
          builder: (_, state) => ArtistPage(state.extra as Artist),
        ),
        GoRoute(
          path: AppPages.short.path,
          builder: (_, state) {
            final params = state.extra as Map<String, dynamic>;
            return ShortPage(
              index: params['index'] as int,
              shorts: params['shorts'] as Iterable<Short>,
            );
          },
        ),
      ],
    );
  }
}
