part of 'horizontal_page.dart';

class HorizontalState {
  final String backgroundUrl;
  final MusicLanguage? subtitleLanguage;

  HorizontalState._({
    required this.backgroundUrl,
    required this.subtitleLanguage,
  });

  factory HorizontalState.initial() {
    return HorizontalState._(
      subtitleLanguage: appStorage.getSubtitleLanguage(),
      backgroundUrl: 'https://static.vecteezy.com/system/resources/previews/002/058/477/original/floral-nature-spring-background-free-vector.jpg',
    );
  }

  HorizontalState copyWith({
    String? backgroundUrl,
    MusicLanguage? subtitleLanguage,
  }) {
    return HorizontalState._(
      subtitleLanguage: subtitleLanguage,
      backgroundUrl: backgroundUrl ?? this.backgroundUrl,
    );
  }
}
