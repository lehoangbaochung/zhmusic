import 'dart:math';

import '/exports/entities.dart';

extension MusicX<T extends Music> on Iterable<T> {
  static final _random = Random.secure();

  String getName(MusicLanguage language, {String separator = separator}) {
    return map((e) => e.getName(language)).join(separator);
  }

  /// Returns the elements of this [Iterable] randomly.
  Iterable<T> get shuffled => toList()..shuffle(_random);

  /// Returns an element of this [Iterable] randomly.
  T get random => _random.nextBool() ? shuffled.first : shuffled.last;
}
