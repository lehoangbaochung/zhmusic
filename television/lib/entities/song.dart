import 'package:src/exports/entities.dart';

typedef Playlist = Map<YoutubeMusic, int>;

class Song {
  final int vote;
  final YoutubeMusic song;

  Song({
    this.vote = 0,
    required this.song,
  });
}
