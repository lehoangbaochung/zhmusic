import 'package:src/exports/entities.dart';

extension MusicX<T extends Music> on Iterable<T> {
  String getName(MusicLanguage language, {String separator = separator}) {
    return map((e) => e.getName(language)).join(separator);
  }
}
