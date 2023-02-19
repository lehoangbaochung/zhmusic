import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '/configs/firebase_options.dart';
import 'entities.dart';

final musicStorage = _MusicStorage();

class _MusicStorage {
  late final _shelf = <String, dynamic>{};
  late final _database = FirebaseFirestore.instance;

  static const audio = 'audio';
  static const artist = 'artist';
  static const short = 'short';

  Future<void> ensureInitialized() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<Iterable<Artist>> getArtists() async {
    if (_shelf.containsKey(artist)) return _shelf[artist];
    final query = await _database
        .collection(artist)
        .withConverter(
          toFirestore: (obj, _) => obj.toJson(),
          fromFirestore: (doc, _) => Artist.fromJson(doc.id, doc.data()!),
        )
        .get();
    return _shelf[artist] = query.docs.map((doc) => doc.data());
  }

  Future<Iterable<Audio>> getAudios() async {
    if (_shelf.containsKey(audio)) return _shelf[audio];
    final query = await _database
        .collection(audio)
        .withConverter(
          toFirestore: (obj, _) => obj.toJson(),
          fromFirestore: (doc, _) => Audio.fromJson(doc.id, doc.data()!),
        )
        .get();
    return _shelf[audio] = query.docs.map((doc) => doc.data());
  }

  Future<Iterable<Short>> getShorts() async {
    if (_shelf.containsKey(short)) return _shelf[short];
    final query = await _database
        .collection(short)
        .withConverter(
          toFirestore: (obj, _) => obj.toJson(),
          fromFirestore: (doc, _) => Short.fromJson(doc.id, doc.data()!),
        )
        .get();
    return _shelf[short] = query.docs.map((doc) => doc.data());
  }
}
