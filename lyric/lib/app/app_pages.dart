import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:src/exports/entities.dart';

import '/pages/audio_page.dart';
import '/pages/lyric_page.dart';
import '/pages/settings_page.dart';

export '/pages/search_page.dart';

enum AppPages {
  audio,
  lyric,
  settings;

  String get path => '/$name';

  /// Pop the top-most route off the [Navigator] that most tightly encloses the given [context].
  static void pop(BuildContext context) => Navigator.pop(context);

  /// Push a [path] onto the stack with an optional [data] object.
  static void push(BuildContext context, String path, [dynamic data]) => context.push(path, extra: data);

  static GoRouter get routerConfig {
    return GoRouter(
      initialLocation: AppPages.audio.path,
      routes: [
        GoRoute(
          path: AppPages.audio.path,
          builder: (_, __) => const AudioPage(),
        ),
        GoRoute(
          path: AppPages.lyric.path,
          builder: (_, state) => LyricPage(state.extra as Audio),
        ),
        GoRoute(
          path: AppPages.settings.path,
          builder: (_, __) => const SettingsPage(),
        ),
      ],
    );
  }
}
