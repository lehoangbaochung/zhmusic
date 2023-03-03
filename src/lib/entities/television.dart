import 'package:src/exports/entities.dart';

class Television implements Entities {
  final String about;
  final String help;
  final Iterable<String> stickers;
  final Iterable<String> informations;

  const Television._({
    required this.about,
    required this.help,
    required this.stickers,
    required this.informations,
  });

  factory Television.fromJson(Map<String, dynamic> fields) {
    return Television._(
      stickers: [],
      about: fields['about'] ?? empty,
      help: fields['help'] ?? empty,
      informations: List.from(fields['info'] ?? []),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'about': about,
      'help': help,
      'info': informations,
    };
  }
}
