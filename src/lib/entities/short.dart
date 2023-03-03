import 'package:src/exports/entities.dart';
import 'package:src/repositories/storage.dart';

// ignore: must_be_immutable
class Short extends YoutubeMusic implements Entities {
  static final Map<String, Short> _shelf = {};

  Short._(
    super.id,
    this._audios,
    this._artists, {
    required super.name,
    required super.description,
  });

  dynamic _audios;
  dynamic _artists;

  factory Short.fromJson(String id, Map<String, dynamic> fields) {
    return _shelf.putIfAbsent(id, () {
      return Short._(
        id,
        List.from(fields['audios'] ?? []),
        List.from(fields['artists'] ?? []),
        name: Map.from(fields['name'] ?? {}),
        description: Map.from(fields['desc'] ?? {}),
      );
    });
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      id: {
        'name': name,
        'desc': description,
        'audios': _audios,
        'artists': _artists,
      },
    };
  }

  Future<Iterable<Audio>> getAudios() async {
    if (_audios is Iterable<Audio>) return _audios;
    final audios = <Audio>[];
    final audiosCollection = await musicStorage.getAudios();
    for (final id in _audios) {
      audios.addAll(
        audiosCollection.where(
          (audio) => audio.id == id,
        ),
      );
    }
    return _audios = audios;
  }

  @override
  Future<Iterable<Artist>> getArtists() async {
    final artists = <Artist>[];
    final artistsCollection = await musicStorage.getArtists();
    for (final id in _artists) {
      artists.addAll(
        artistsCollection.where(
          (artist) => artist.id == id,
        ),
      );
    }
    return artists;
  }
}
