import 'entities.dart';

export '/extensions/artist.dart';
export '/extensions/audio.dart';
export '/extensions/music.dart';

extension DurationX on Duration {
  String twoDigits(int n) => '$n'.padLeft(2, '0');

  String format() {
    return '${inMinutes.remainder(60)}:${twoDigits(inSeconds.remainder(60))}';
  }
}

extension DateTimeX on DateTime {
  String format({String separator = separator}) => '$day$separator$month$separator$year';
}
