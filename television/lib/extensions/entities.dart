import 'package:src/exports/entities.dart';

extension PlaylistX on Map<YoutubeMusic, int> {
  Map<YoutubeMusic, int> get sorted {
    final songs = keys.toList()
      ..sort((song1, song2) {
        final vote1 = this[song1] ?? 0;
        final vote2 = this[song2] ?? 0;
        return vote2.compareTo(vote1);
      });
    return {for (final song in songs) song: this[song] ?? 0};
  }
}
