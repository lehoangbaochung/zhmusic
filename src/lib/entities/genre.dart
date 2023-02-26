import 'package:src/exports/entities.dart';

class Genre extends Music {
  static final Map<String, Genre> _shelf = {};

  const Genre._(
    super.id, {
    required super.name,
    required super.description,
  });

  factory Genre.fromJson(String id, Map<String, dynamic> fields) {
    return _shelf.putIfAbsent(id, () {
      return Genre._(
        id,
        name: Map.castFrom(fields['name']),
        description: Map.castFrom(fields['desc'] ?? {}),
      );
    });
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      id: {
        'name': name,
        'desc': description,
      },
    };
  }
}
