import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '/configs/firebase_options.dart';
import '/exports/entities.dart';

final musicStorage = _MusicStorage();

class _MusicStorage {
  late final _shelf = <String, dynamic>{};
  late final _database = FirebaseFirestore.instance;

  static const music = 'music';
  static const account = 'account';
  static const audio = 'audio';
  static const artist = 'artist';
  static const short = 'short';
  static const genre = 'genre';
  static const television = 'television';

  Future<void> ensureInitialized() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<Iterable<Account>> getAccounts() async {
    if (_shelf.containsKey(account)) return _shelf[account];
    final query = await _database
        .collection(account)
        .withConverter(
          toFirestore: (obj, _) => obj.toJson(),
          fromFirestore: (doc, _) => Account.fromJson(doc.id, doc.data()!),
        )
        .get();
    return _shelf[account] = query.docs.map((doc) => doc.data());
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

  Future<Iterable<Genre>> getGenres() async {
    if (_shelf.containsKey(genre)) return _shelf[genre];
    final query = await _database
        .collection(genre)
        .withConverter(
          toFirestore: (obj, _) => obj.toJson(),
          fromFirestore: (doc, _) => Genre.fromJson(doc.id, doc.data()!),
        )
        .get();
    return _shelf[genre] = query.docs.map((doc) => doc.data());
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

  Future<Television> getTelevision() async {
    if (_shelf.containsKey(television)) return _shelf[television];
    final query = await _database
        .collection(music)
        .doc(television)
        .withConverter(
          toFirestore: (obj, _) => obj.toJson(),
          fromFirestore: (doc, _) => Television.fromJson(doc.data()!),
        )
        .get();
    return _shelf[television] = query.data()!;
  }
}
