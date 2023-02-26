import 'package:flutter/material.dart';

@immutable
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

  Map<String, dynamic> toJson();

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

  String get name {
    switch (this) {
      case MusicLanguage.vi:
        return 'vi';
      case MusicLanguage.zh:
        return 'zh';
      case MusicLanguage.zhHans:
        return 'zh-Hans';
      case MusicLanguage.zhHant:
        return 'zh-Hant';
    }
  }
}

enum MusicType {
  audio,
  lyric,
  music,
  short,
  television;

  String get title {
    final last = name.substring(1);
    final first = name.substring(0, 1).toUpperCase();
    return 'Zither Harp Music (${first + last})';
  }

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
      case MusicType.television:
        return Colors.green;
      case MusicType.music:
        return Colors.white;
    }
  }
}
