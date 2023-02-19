import 'package:shared_preferences/shared_preferences.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/repositories.dart';

final appStorage = _AppStorage();

class _AppStorage {
  late final SharedPreferences _preferences;

  static const favoriteSongs = 'favorite_songs';

  Future<void> ensureInitialized() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future<Iterable<YoutubeMusic>> getFavoriteSongs() async {
    final songIds = _preferences.getStringList(favoriteSongs) ?? [];
    if (songIds.isEmpty) return [];
    final songs = await musicStorage.getAudios();
    return songIds.map((id) => songs.singleWhere((song) => song.id == id));
  }

  Future<bool> setFavoriteSongs(Iterable<YoutubeMusic> songs) async {
    final songIds = songs.map((song) => song.id).toList();
    return _preferences.setStringList(favoriteSongs, songIds);
  }
}
