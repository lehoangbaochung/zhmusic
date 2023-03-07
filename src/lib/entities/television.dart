import 'package:src/exports/entities.dart';

class Television implements Entities {
  final String about;
  final String help;
  final Iterable<Message> chat;
  final Iterable<String> playlist;
  final Iterable<String> stickers;
  final Iterable<String> informations;

  const Television._({
    required this.about,
    required this.help,
    required this.chat,
    required this.playlist,
    required this.stickers,
    required this.informations,
  });

  factory Television.fromJson(Map<String, dynamic> fields) {
    return Television._(
      stickers: [],
      about: fields['about'] ?? empty,
      help: fields['help'] ?? empty,
      chat: List.from(fields['chat'] ?? []).map((field) => Message.fromJson(field)),
      playlist: List.from(fields['playlist'] ?? []),
      informations: List.from(fields['info'] ?? []),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'about': about,
      'help': help,
      'chat': chat,
      'playlist': playlist,
      'info': informations,
    };
  }
}

class Message {
  final String id;
  final String content;
  final DateTime publishTime;

  Message._({
    required this.id,
    required this.content,
    required this.publishTime,
  });

  factory Message.fromJson(Map<String, dynamic> fields) {
    return Message._(
      id: fields['user'],
      content: fields['content'],
      publishTime: DateTime.parse(fields['time'].toDate().toString()),
    );
  }
}
