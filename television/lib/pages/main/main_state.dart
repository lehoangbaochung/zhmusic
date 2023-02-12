part of 'main_page.dart';

class MainState {
  final bool themeMode;
  final YoutubeMusic playingSong;
  final Iterable<YoutubeMusic> library;
  final Map<YoutubeMusic, int> playlist;

  const MainState._({
    required this.library,
    required this.playlist,
    required this.playingSong,
    required this.themeMode,
  });

  static Future<MainState> initialize({required bool audioOnly}) async {
    final songs = await musicCollection.getAudios();
    final playingSong = songs.random;
    return MainState._(
      library: songs,
      playlist: {for (var song in songs.shuffled.take(15)) song: 0},
      playingSong: playingSong,
      themeMode: true,
    );
  }

  MainState copyWith({
    YoutubeMusic? playingSong,
    Iterable<YoutubeMusic>? library,
    Map<YoutubeMusic, int>? playlist,
    bool? themeMode,
  }) {
    return MainState._(
      library: library ?? this.library,
      playlist: playlist ?? this.playlist,
      playingSong: playingSong ?? this.playingSong,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
