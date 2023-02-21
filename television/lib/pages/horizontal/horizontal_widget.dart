import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/widgets.dart';

import '/pages/horivertical/horivertical_widget.dart';

export '../../widgets/horizontal/buttons/horizontal_elevated_button.dart';
export '../../widgets/horizontal/buttons/horizontal_outlined_button.dart';
export '../../widgets/horizontal/horizontal_marquee_text.dart';

extension HorizontalWidgetX on BuildContext {
  double get songBarHeight => mediaHeight / 5;

  double get songTextHeight => songBarHeight / 3;

  double get marqueeTextHeight => songBarHeight / 5;

  double get fontSize => mediaHeight / 36;

  double get iconSize => mediaHeight / 28;

  TextStyle get songTextStyle {
    return TextStyle(
      color: Colors.white,
      fontSize: mediaHeight / 36,
    );
  }

  TextStyle get labelTextStyle {
    return TextStyle(
      color: Colors.grey,
      fontSize: mediaHeight / 36,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get marqueeTextStyle {
    return TextStyle(
      color: Colors.white,
      fontSize: mediaHeight / 36,
    );
  }

  TextStyle get headlineTextStyle {
    return TextStyle(
      color: Colors.white,
      fontSize: mediaHeight / 24,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get bodyTextStyle {
    return TextStyle(
      fontSize: mediaHeight / 48,
    );
  }

  Future<T?> showHorizontalDialog<T>(Widget dialog) {
    return showModalBottomSheet<T>(
      elevation: 0,
      context: this,
      barrierColor: Colors.transparent,
      builder: (_) => BlocProvider.value(value: playerCubit, child: dialog),
    );
  }
}
