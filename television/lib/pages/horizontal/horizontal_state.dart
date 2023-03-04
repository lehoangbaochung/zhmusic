part of 'horizontal_page.dart';

class HorizontalState {
  final MusicLanguage? subtitleLanguage;

  HorizontalState._({
    required this.subtitleLanguage,
  });

  factory HorizontalState.initial() {
    return HorizontalState._(
      subtitleLanguage: appStorage.getSubtitleLanguage(),
    );
  }

  HorizontalState copyWith({
    String? backgroundUrl,
    MusicLanguage? subtitleLanguage,
  }) {
    return HorizontalState._(
      subtitleLanguage: subtitleLanguage,
    );
  }
}
