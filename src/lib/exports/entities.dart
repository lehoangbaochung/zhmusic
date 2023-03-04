export '/entities/account.dart';
export '/entities/artist.dart';
export '/entities/audio.dart';
export '/entities/genre.dart';
export '/entities/music.dart';
export '/entities/short.dart';
export '/entities/subtitle.dart';
export '/entities/television.dart';
export '/entities/tencent.dart';
export '/entities/youtube.dart';

const empty = '';
const separator = '/';

abstract class Entities {
  Map<String, dynamic> toJson();

  Entities.fromJson(Map<String, dynamic> json);

  Entities.fromFields(String id, Map<String, dynamic> fields);
}