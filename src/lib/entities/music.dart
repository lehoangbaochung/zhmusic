import 'package:flutter/material.dart';

abstract class Music {
  const Music(
    this.id, {
    required this.name,
    required this.description,
  });

  @required
  final String id;

  @protected
  final Map<String, String> name;

  @protected
  final Map<String, String> description;

  String getName(MusicLanguage language) => name[language.name] ?? language.name;

  String getDescription(MusicLanguage language) => description[language.name] ?? language.name;

  @override
  String toString() => '$runtimeType ($id)';

  @override
  int get hashCode => runtimeType.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Music && runtimeType == other.runtimeType && id == other.id;
}

enum MusicLanguage {
  vi,
  zh,
  zhHans,
  zhHant;
}

enum MusicType {
  audio,
  lyric,
  short;

  String get title => 'Zither Harp Music ($name)';

  Image get image {
    return Image.asset(
      'assets/images/$name.png',
      package: 'src',
      fit: BoxFit.cover,
    );
  }

  Color get color {
    switch (this) {
      case MusicType.audio:
        return Colors.blueAccent;
      case MusicType.lyric:
        return Colors.blueGrey;
      case MusicType.short:
        return const Color(0xFFfeafc7);
    }
  }
}
