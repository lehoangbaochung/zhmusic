export 'package:src/entities/music.dart';
export 'package:src/entities/tencent.dart';
export 'package:src/entities/youtube.dart';
export 'package:src/entities/audio.dart';
export 'package:src/entities/artist.dart';
export 'package:src/entities/genre.dart';
export 'package:src/entities/short.dart';
export 'package:src/entities/subtitle.dart';
export 'package:src/entities/television.dart';

const empty = '';
const separator = '/';

abstract class Entities {
  Map<String, dynamic> toJson();

  Entities.fromJson(Map<String, dynamic> json);

  Entities.fromFields(String id, Map<String, dynamic> fields);
}