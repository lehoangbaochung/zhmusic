import 'package:src/exports/entities.dart';

typedef Playlist = Map<YoutubeMusic, Iterable<Account>>;

extension PlaylistX on Playlist {
  Playlist get sorted {
    final songs = keys.toList()
      ..sort((song1, song2) {
        final vote1 = this[song1] ?? [];
        final vote2 = this[song2] ?? [];
        return vote2.length.compareTo(vote1.length);
      });
    return {for (final song in songs) song: this[song] ?? []};
  }
}
