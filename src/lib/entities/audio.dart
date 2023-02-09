import 'package:src/exports/entities.dart';
import 'package:src/exports/repositories.dart';

class Audio extends YoutubeMusic {
  static final Map<String, Audio> _shelf = {};

  Audio._(
    super.id,
    this._artists, {
    required super.name,
    required super.description,
  });

  dynamic _artists;

  factory Audio.fromJson(String id, Map<String, dynamic> fields) {
    return _shelf.putIfAbsent(id, () {
      return Audio._(
        id,
        List.castFrom(fields['artists']),
        name: Map.castFrom(fields['name']),
        description: Map.castFrom(fields['desc'] ?? {}),
      );
    });
  }

  Map<String, dynamic> toJson() {
    return {
      id: {
        'name': name,
        'desc': description,
        'artists': _artists,
      },
    };
  }

  Future<Iterable<Artist>> getArtists() async {
    if (_artists is Iterable<Artist>) return _artists;
    final artists = <Artist>[];
    final artistsCollection = await musicCollection.getArtists();
    for (final id in _artists) {
      artists.addAll(
        artistsCollection.where(
          (artist) => artist.id == id,
        ),
      );
    }
    return _artists = artists;
  }
}
