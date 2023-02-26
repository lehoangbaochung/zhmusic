part of 'horizontal_page.dart';

class HorizontalCubit extends Cubit<HorizontalState> {
  HorizontalCubit() : super(HorizontalState.initial());

  void changeSubtitleLanguage(MusicLanguage? language) {
    emit(
      state.copyWith(
        subtitleLanguage: language,
      ),
    );
  }
}
