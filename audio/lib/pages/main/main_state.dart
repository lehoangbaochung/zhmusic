part of 'main_page.dart';

class MainState {
  final Iterable<Audio> playlist;

  MainState._({
    required this.playlist,
  });

  factory MainState.initial() {
    return MainState._(
      playlist: [],
    );
  }
}
