import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/entities.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState.initial());

  void toggle() {
    emit(
      state.copyWith(
        isPlaying: !state.isPlaying,
      ),
    );
  }

  void setPlaylist(int index, Iterable<Audio> audios) {
    emit(
      state.copyWith(
        index: index,
        playlist: audios,
        isPlaying: true,
      ),
    );
  }
}

class AppState {
  final int index;
  final bool isPlaying;
  final Iterable<Audio> playlist;

  Audio get currentSong => playlist.elementAt(index);

  AppState._({
    required this.index,
    required this.playlist,
    required this.isPlaying,
  });

  factory AppState.initial() {
    return AppState._(
      index: 0,
      playlist: [],
      isPlaying: false,
    );
  }

  AppState copyWith({
    int? index,
    bool? isPlaying,
    Iterable<Audio>? playlist,
  }) {
    return AppState._(
      index: index ?? this.index,
      playlist: playlist ?? this.playlist,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
