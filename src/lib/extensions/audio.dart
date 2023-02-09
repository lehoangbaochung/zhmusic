import 'package:src/exports/entities.dart';
import 'package:src/exports/repositories.dart';

extension AudioX on Audio {
  static final _shorts = <String, Iterable<Short>>{};

  Future<Iterable<Short>> getShorts() async {
    if (_shorts.containsKey(id)) return Future.value(_shorts[id]);
    final shorts = <Short>[];
    final shortsCollection = await musicCollection.getShorts();
    for (final short in shortsCollection) {
      final audios = await short.getAudios();
      if (audios.any((audio) => audio.id == id)) {
        shorts.add(short);
        continue;
      }
    }
    return _shorts[id] = shorts;
  }
}
