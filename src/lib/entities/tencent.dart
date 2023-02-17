import 'package:src/entities/music.dart';

abstract class TencentMusic extends Music {
  const TencentMusic(
    super.id, {
    required super.name,
    required super.description,
    this.type = TencentMusicType.unknown,
  });

  final TencentMusicType type;

  String getImageUrl([TencentMusicImage image = TencentMusicImage.small]) {
    return 'https://y.qq.com/music/photo_new/T00${type.index}R${image.dimension}x${image.dimension}M000$id.jpg';
  }
}

enum TencentMusicType {
  unknown,
  artist,
  album;
}

enum TencentMusicImage {
  small(300),
  medium(500),
  large(800);

  const TencentMusicImage(this.dimension);

  final int dimension;
}
