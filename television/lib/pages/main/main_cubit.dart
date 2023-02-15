part of 'main_page.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(super.initialState);

  void _fill() {
    if (state.playlist.length >= 15) return;
    while (state.playlist.length < 15) {
      final song = state.library.random;
      if (!state.playlist.keys.any((e) => e.id == song.id)) {
        state.playlist.addAll({song: 0});
      }
    }
    emit(
      state.copyWith(
        playlist: state.playlist,
      ),
    );
  }

  Future<void> next() async {
    final nextSong = state.playlist.keys.first;
    emit(
      state.copyWith(
        playingSong: nextSong,
        playlist: state.playlist..remove(nextSong),
        playerController: VideoPlayerController.network(
          await nextSong.getStreamUrl(audioOnly: state.audioOnly),
        ),
      ),
    );
    _fill();
  }

  void vote(YoutubeMusic song) {
    if (state.playlist.containsKey(song)) {
      state.playlist.update(song, (value) => value += 1);
    } else {
      state.playlist.addAll({song: 1});
    }
    var sortedKeys = state.playlist.keys.toList()..sort((k1, k2) => state.playlist[k2]!.compareTo(state.playlist[k1]!));
    var sortedMap = {for (var k in sortedKeys) k: state.playlist[k]!};
    emit(
      state.copyWith(
        playlist: sortedMap,
      ),
    );
    _fill();
  }

  void setThemeMode(bool themeMode) {
    emit(
      state.copyWith(
        themeMode: themeMode,
      ),
    );
  }
}
