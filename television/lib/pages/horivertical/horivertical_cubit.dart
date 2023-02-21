part of 'horivertical_page.dart';

class HoriverticalCubit extends Cubit<HoriverticalState> {
  late AudioPlayer player;

  HoriverticalCubit(super.initialState) {
    player = AudioPlayer()
      ..onPlayerComplete.listen((_) {
        next();
      });
    state.playingSong
        .getStreamUrl(
      audioOnly: state.audioOnly,
    )
        .then((url) {
      state.copyWith(
        playingSong: state.playingSong,
      );
      player.play(
        UrlSource(url),
        mode: PlayerMode.mediaPlayer,
        volume: appStorage.getPlayerVolume(),
      );
    });
  }

  void _fill() {
    if (state.playlist.length >= 15) return;
    while (state.playlist.length < 15) {
      final nextSong = state.library.random;
      if (state.playlist.keys.contains(nextSong)) continue;
      state.playlist.addAll({nextSong: 0});
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
        await nextSong.getStreamUrl(
          audioOnly: state.audioOnly,
        ),
      ),
    );
  }

  void vote(YoutubeMusic song) {
    if (state.playlist.containsKey(song)) {
      state.playlist.update(song, (value) => value += 1);
    } else {
      state.playlist.addAll({song: 1});
    }
    emit(
      state.copyWith(
        playlist: state.playlist.sorted,
      ),
    );
    _fill();
  }
}
