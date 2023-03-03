import 'package:src/exports/entities.dart';
import 'package:src/repositories/storage.dart';

// ignore: must_be_immutable
class Audio extends YoutubeMusic implements Entities {
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
        List.from(fields['artists']),
        name: Map.castFrom(fields['name']),
        description: Map.castFrom(fields['desc'] ?? {}),
      );
    });
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      id: {
        'name': name,
        'desc': description,
        'artists': _artists,
      },
    };
  }

  @override
  Future<Iterable<Artist>> getArtists() async {
    final artistsId = List<String>.from(_artists);
    final artistsCollection = await musicStorage.getArtists();
    return artistsId.map(
      (id) => artistsCollection.singleWhere(
        orElse: () => Artist.empty,
        (artist) => artist.id == id,
      ),
    );
  }
}
