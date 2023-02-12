part of 'main_page.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(super.initialState);

  var index = 0;

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

  void next() {
    emit(
      state.copyWith(
        playingSong: state.playlist.keys.first,
        playlist: state.playlist..remove(state.playlist.keys.first),
      ),
    );
    _fill();
    index -= 1;
  }

  void vote(YoutubeMusic song) {
    if (state.playlist.containsKey(song)) {
      state.playlist.update(song, (value) => value += 1);
    } else {
      state.playlist.addAll({song: 1});
    }
    var sortedKeys = state.playlist.keys.toList()..sort((k1, k2) => state.playlist[k2]!.compareTo(state.playlist[k1]!));
    var sortedMap = { for (var k in sortedKeys) k : state.playlist[k]! };
    emit(
      state.copyWith(
        playlist: sortedMap,
      ),
    );
    _fill();
    index += 1;
  }

  void setThemeMode(bool themeMode) {
    emit(
      state.copyWith(
        themeMode: themeMode,
      ),
    );
  }
}
