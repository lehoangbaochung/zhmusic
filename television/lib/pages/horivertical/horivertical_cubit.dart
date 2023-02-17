part of 'horivertical_page.dart';

class HoriverticalCubit extends Cubit<HoriverticalState> {
  late AudioPlayer player;

  HoriverticalCubit(HoriverticalState initialState) : super(initialState) {
    player = AudioPlayer()
      ..onPlayerComplete.listen((_) {
        next();
      });
    initialState.playingSong
        .getStreamUrl(
      audioOnly: initialState.audioOnly,
    )
        .then((url) {
      player.play(UrlSource(url));
    });
  }

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

  void next() async {
    final nextSong = state.playlist.keys.first;
    emit(
      state.copyWith(
        playingSong: nextSong,
        playlist: state.playlist..remove(nextSong),
      ),
    );
    _fill();
    await player.play(
      UrlSource(
        await nextSong.getStreamUrl(audioOnly: state.audioOnly),
      ),
    );
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
}
