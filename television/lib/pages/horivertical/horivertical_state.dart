part of 'horivertical_page.dart';

class HoriverticalState {
  final HoriverticalMode mode;
  final HoriverticalType type;
  final HoriverticalSource source;

  final YoutubeMusic playingSong;
  final Iterable<YoutubeMusic> library;
  final Map<YoutubeMusic, int> playlist;

  const HoriverticalState._({
    required this.mode,
    required this.type,
    required this.source,
    required this.playingSong,
    required this.library,
    required this.playlist,
  });

  static Future<HoriverticalState> initial({
    required HoriverticalMode mode,
    required HoriverticalType type,
    required HoriverticalSource source,
  }) async {
    final songs = await musicStorage.getAudios();
    return HoriverticalState._(
      mode: mode,
      type: type,
      source: source,
      library: songs,
      playingSong: songs.random,
      playlist: {for (var song in songs.shuffled.take(15)) song: 0},
    );
  }

  HoriverticalState copyWith({
    YoutubeMusic? playingSong,
    Iterable<YoutubeMusic>? library,
    Map<YoutubeMusic, int>? playlist,
  }) {
    return HoriverticalState._(
      mode: mode,
      type: type,
      source: source,
      library: library ?? this.library,
      playlist: playlist ?? this.playlist,
      playingSong: playingSong ?? this.playingSong,
    );
  }
}
