part of 'horivertical_page.dart';

class HoriverticalState {
  final bool audioOnly;
  final YoutubeMusic playingSong;
  final Iterable<YoutubeMusic> library;
  final Map<YoutubeMusic, int> playlist;

  const HoriverticalState._({
    required this.audioOnly,
    required this.library,
    required this.playlist,
    required this.playingSong,
  });

  static Future<HoriverticalState> initial({required bool audioOnly}) async {
    final songs = await musicCollection.getAudios();
    return HoriverticalState._(
      audioOnly: audioOnly,
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
      audioOnly: audioOnly,
      library: library ?? this.library,
      playlist: playlist ?? this.playlist,
      playingSong: playingSong ?? this.playingSong,
    );
  }
}
