part of 'main_page.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit(super.initialState);

  void _fill() {
    if (state.playlist.length >= 15) return;
    while (state.playlist.length < 15) {
      final song = state.library.random;
      if (!state.playlist.contains(song)) {
        state.playlist.followedBy([song]);
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
        playingSong: state.playlist.first,
        playlist: state.playlist.toList()..removeAt(0),
      ),
    );
    _fill();
  }

  void refresh() {}
}
