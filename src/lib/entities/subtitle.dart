import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class Subtitle {
  /// An empty [Subtitle], representing no subtitle.
  static const empty = Subtitle(start: Duration.zero, end: Duration.zero, text: '');

  /// Time at which this subtitle starts being displayed.
  final Duration start;

  /// Time at which this subtitle ends being displayed.
  final Duration end;

  /// Text displayed by this subtitle.
  final String text;

  /// Duration this subtitle is displayed.
  Duration get duration => start + end;

  const Subtitle({
    required this.start,
    required this.end,
    required this.text,
  });

  /// Creates a new subtitle from a [ClosedCaption].
  factory Subtitle.fromCaption(ClosedCaption caption) {
    return Subtitle(
      start: caption.offset,
      end: caption.end,
      text: caption.text,
    );
  }

  int get cps => text.length ~/ duration.inSeconds;
}

enum SubtitleExtensions {
  lrc,
  srt,
  sbv,
  vtt;
}
