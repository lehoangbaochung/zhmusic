part of 'main_page.dart';

class MainState {
  final bool themeMode;

  MainState._({
    required this.themeMode,
  });

  factory MainState.initial() {
    return MainState._(themeMode: true);
  }
}
