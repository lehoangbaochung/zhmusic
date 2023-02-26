import 'package:shared_preferences/shared_preferences.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/repositories.dart';

final appStorage = _AppStorage();

class _AppStorage {
  late final SharedPreferences _preferences;

  static const playerVolume = 'player_volume';
  static const favoriteSongs = 'favorite_songs';
  static const primarySubtitle = 'primary_subtitle';

  Future<void> ensureInitialized() async {
    _preferences = await SharedPreferences.getInstance();
  }

  double getPlayerVolume() => _preferences.getDouble(playerVolume) ?? 1;

  Future<bool> setPlayerVolume(double volume) => _preferences.setDouble(playerVolume, volume);

  Future<Iterable<YoutubeMusic>> getFavoriteSongs() async {
    final songIds = _preferences.getStringList(favoriteSongs) ?? [];
    if (songIds.isEmpty) return [];
    final songs = await musicStorage.getAudios();
    return songIds.map((id) => songs.singleWhere((song) => song.id == id));
  }

  Future<bool> setFavoriteSongs(Iterable<YoutubeMusic> songs) {
    final songIds = songs.map((song) => song.id).toList();
    return _preferences.setStringList(favoriteSongs, songIds);
  }

  MusicLanguage? getSubtitleLanguage() {
    final languageCode = _preferences.getString(primarySubtitle) ?? empty;
    if (languageCode == empty) return null;
    return MusicLanguage.values.byName(languageCode);
  }

  Future<bool> setSubtitleLanguage(MusicLanguage? language) {
    return _preferences.setString(primarySubtitle, language?.name ?? empty);
  }
}
