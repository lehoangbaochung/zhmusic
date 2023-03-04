part of 'horivertical_page.dart';

class HoriverticalState {
  final HoriverticalMode mode;
  final HoriverticalType type;
  final HoriverticalTheme theme;
  final HoriverticalSource source;

  final YoutubeMusic playingSong;
  final Iterable<YoutubeMusic> library;
  final Map<YoutubeMusic, Iterable<Account>> playlist;

  const HoriverticalState._({
    required this.mode,
    required this.type,
    required this.theme,
    required this.source,
    required this.playingSong,
    required this.library,
    required this.playlist,
  });

  static Future<HoriverticalState> initial({
    required HoriverticalMode mode,
    required HoriverticalType type,
    required HoriverticalTheme theme,
    required HoriverticalSource source,
  }) async {
    final songs = await musicStorage.getAudios();
    return HoriverticalState._(
      mode: mode,
      type: type,
      theme: theme,
      source: source,
      library: songs,
      playingSong: songs.random,
      playlist: {for (var song in songs.shuffled.take(15)) song: []},
    );
  }

  HoriverticalState copyWith({
    YoutubeMusic? playingSong,
    Iterable<YoutubeMusic>? library,
    Map<YoutubeMusic, Iterable<Account>>? playlist,
  }) {
    return HoriverticalState._(
      mode: mode,
      type: type,
      theme: theme,
      source: source,
      library: library ?? this.library,
      playlist: playlist ?? this.playlist,
      playingSong: playingSong ?? this.playingSong,
    );
  }
}
