part of 'horivertical_page.dart';

class HoriverticalCubit extends Cubit<HoriverticalState> {
  HoriverticalCubit._(super.initialState);

  static Future<HoriverticalCubit> initial(HoriverticalState state) async {
    final firstSong = state.playingSong;
    final cubit = HoriverticalCubit._(state);
    final artists = await firstSong.getArtists();
    final streamUrl = await firstSong.getStreamUrl(
      audioOnly: state.source == HoriverticalSource.audio,
    );
    player = AudioPlayer()
      ..playerStateStream.listen(
        (playerState) {
          if (playerState.processingState == ProcessingState.completed) {
            cubit.next();
          }
        },
      )
      ..setAudioSource(
        AudioSource.uri(
          Uri.parse(streamUrl),
          tag: MediaItem(
            id: firstSong.id,
            artist: artists.getName(MusicLanguage.vi),
            title: firstSong.getName(MusicLanguage.vi),
            artUri: Uri.parse(
              firstSong.getImageUrl(
                YoutubeThumbnail.hqdefault,
              ),
            ),
          ),
        ),
      )
      ..setVolume(
        appStorage.getPlayerVolume(),
      )
      ..play();
    return Future.value(cubit);
  }

  void _fill() {
    if (state.playlist.length >= 15) return;
    while (state.playlist.length < 15) {
      final nextSong = state.library.random;
      if (state.playlist.keys.contains(nextSong)) continue;
      state.playlist.addAll({nextSong: []});
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
    final artists = await nextSong.getArtists();
    final streamUrl = await nextSong.getStreamUrl(
      audioOnly: state.source == HoriverticalSource.audio,
    );
    await player.setAudioSource(
      AudioSource.uri(
        Uri.parse(streamUrl),
        tag: MediaItem(
          id: nextSong.id,
          title: nextSong.getName(MusicLanguage.vi),
          artist: artists.getName(MusicLanguage.vi),
          artUri: Uri.parse(
            nextSong.getImageUrl(
              YoutubeThumbnail.hqdefault,
            ),
          ),
        ),
      ),
    );
    await player.play();
  }

  void vote(YoutubeMusic song) {
    state.playlist.update(
      ifAbsent: () => [],
      song,
      (value) => value.toList()..add(Account.empty),
    );
    emit(
      state.copyWith(
        playlist: state.playlist.sorted,
      ),
    );
  }
}
