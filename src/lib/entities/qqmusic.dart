import 'package:src/entities/music.dart';

abstract class QQMusic extends Music {
  const QQMusic(
    super.id, {
    required super.name,
    required super.description,
    this.type = QQMusicType.unknown,
  });

  final QQMusicType type;

  String getImageUrl([QQMusicImage image = QQMusicImage.small]) {
    return 'https://y.qq.com/music/photo_new/T00${type.index}R${image.dimension}x${image.dimension}M000$id.jpg';
  }
}

enum QQMusicType {
  unknown,
  artist,
  album;
}

enum QQMusicImage {
  small(300),
  medium(500),
  large(800);

  const QQMusicImage(this.dimension);

  final int dimension;
}
