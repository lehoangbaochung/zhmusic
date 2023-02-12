part of 'horizontal_page.dart';

class HorizontalState {
  final String backgroundUrl;

  HorizontalState._({
    required this.backgroundUrl,
  });

  factory HorizontalState.initial() {
    return HorizontalState._(
      backgroundUrl: 'https://static.vecteezy.com/system/resources/previews/002/058/477/original/floral-nature-spring-background-free-vector.jpg',
    );
  }

  HorizontalState copyWith({
    String? backgroundUrl,
  }) {
    return HorizontalState._(
      backgroundUrl: backgroundUrl ?? this.backgroundUrl,
    );
  }
}
