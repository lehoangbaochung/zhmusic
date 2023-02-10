import 'tencent.dart';

class Artist extends QQMusic {
  static final Map<String, Artist> _shelf = {};
  
  const Artist._(
    super.id, {
    required super.name,
    required super.description,
    // ignore: unused_element
    super.type = QQMusicType.artist,
  });

  factory Artist.fromJson(String id, Map<String, dynamic> fields) {
    return _shelf.putIfAbsent(id, () {
      return Artist._(
        id,
        name: Map.castFrom(fields['name']),
        description: Map.castFrom(fields['desc'] ?? {}),
      );
    });
  }

  Map<String, dynamic> toJson() {
    return {
      id: {
        'name': name,
        'desc': description,
      },
    };
  }
}
