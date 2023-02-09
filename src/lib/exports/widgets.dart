import 'package:flutter/material.dart';

/// A box that will become as small as its parent allows.
const emptyPlaceholder = SizedBox.shrink();

/// A circular progress indicator that centers its parent.
const centeredLoadingIndicator = Center(
  child: CircularProgressIndicator(),
);

extension BuildContextX on BuildContext {
  /// The size of the media in logical pixels.
  Size get mediaSize => MediaQuery.of(this).size;

  /// Text with a color that contrasts with the card and canvas colors.
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// The color displayed most frequently across your app's screens and components.
  Color get primaryColor => Theme.of(this).colorScheme.primary;

  /// An accent color used for less prominent components in the UI.
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;

  /// A color that's clearly legible when drawn on background.
  Color get backgroundColor => Theme.of(this).colorScheme.onPrimary;
}

extension ColorX on Color {
  MaterialColor toMaterialColor() {
    final strengths = [.05];
    final swatch = <int, Color>{};
    final int r = red, g = green, b = blue;
    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (final strength in strengths) {
      final ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(value, swatch);
  }
}
