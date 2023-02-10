part of 'main_page.dart';

class MainState {
  final YoutubeMusic playingSong;
  final Iterable<YoutubeMusic> library;
  final Iterable<YoutubeMusic> playlist;

  const MainState._({
    required this.library,
    required this.playlist,
    required this.playingSong,
  });

  static Future<MainState> initialize({required bool audioOnly}) async {
    final songs = await musicCollection.getAudios();
    return MainState._(
      library: songs,
      playlist: songs.shuffled.take(15),
      playingSong: songs.random,
    );
  }

  MainState copyWith({
    YoutubeMusic? playingSong,
    Iterable<YoutubeMusic>? library,
    Iterable<YoutubeMusic>? playlist,
  }) {
    return MainState._(
      library: library ?? this.library,
      playlist: playlist ?? this.playlist,
      playingSong: playingSong ?? this.playingSong,
    );
  }
}
