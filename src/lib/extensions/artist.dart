import 'package:src/exports/entities.dart';
import 'package:src/exports/repositories.dart';

extension ArtistX on Artist {
  static final _audios = <String, Iterable<Audio>>{};
  static final _shorts = <String, Iterable<Short>>{};

  Future<Iterable<Audio>> getAudios() async {
    if (_audios.containsKey(id)) return Future.value(_audios[id]);
    final audios = <Audio>[];
    final audiosCollection = await musicCollection.getAudios();
    for (final audio in audiosCollection) {
      final artists = await audio.getArtists();
      if (artists.any((artist) => artist.id == id)) {
        audios.add(audio);
        continue;
      }
    }
    return _audios[id] = audios;
  }

  Future<Iterable<Short>> getShorts() async {
    if (_shorts.containsKey(id)) return Future.value(_shorts[id]);
    final shorts = <Short>[];
    final shortsCollection = await musicCollection.getShorts();
    for (final short in shortsCollection) {
      final artists = await short.getArtists();
      if (artists.any((artist) => artist.id == id)) {
        shorts.add(short);
        continue;
      }
    }
    return _shorts[id] = shorts;
  }
}
