part of 'main_page.dart';

class MainState {
  final bool themeMode;
  final bool audioOnly;
  final YoutubeMusic playingSong;
  final Iterable<YoutubeMusic> library;
  final Map<YoutubeMusic, int> playlist;
  final VideoPlayerController playerController;

  const MainState._({
    required this.audioOnly,
    required this.library,
    required this.playlist,
    required this.playingSong,
    required this.themeMode,
    required this.playerController,
  });

  static Future<MainState> initial({required bool audioOnly}) async {
    final songs = await musicCollection.getAudios();
    final playingSong = songs.random;
    final playerController = VideoPlayerController.network(
      await playingSong.getStreamUrl(audioOnly: audioOnly),
    );
    return MainState._(
      audioOnly: audioOnly,
      library: songs,
      playlist: {for (var song in songs.shuffled.take(15)) song: 0},
      playingSong: playingSong,
      themeMode: true,
      playerController: playerController,
    );
  }

  MainState copyWith({
    YoutubeMusic? playingSong,
    Iterable<YoutubeMusic>? library,
    Map<YoutubeMusic, int>? playlist,
    VideoPlayerController? playerController,
    bool? themeMode,
  }) {
    return MainState._(
      audioOnly: audioOnly,
      library: library ?? this.library,
      playlist: playlist ?? this.playlist,
      playingSong: playingSong ?? this.playingSong,
      themeMode: themeMode ?? this.themeMode,
      playerController: playerController ?? this.playerController,
    );
  }
}
