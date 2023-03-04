import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/widgets.dart';

import '/pages/horivertical/horivertical_widget.dart';
import 'horizontal_page.dart';

export 'package:src/exports/widgets.dart';
export '/widgets/horizontal/horizontal_elevated_button.dart';
export '/widgets/horizontal/horizontal_outlined_button.dart';
export '/widgets/horizontal/horizontal_marquee_text.dart';

extension HorizontalWidgetX on BuildContext {
  HorizontalCubit get horizontalCubit => read<HorizontalCubit>();

  HorizontalState get horizontalState => watch<HorizontalCubit>().state;

  double get songBarHeight => mediaHeight / 5;

  double get songTextHeight => songBarHeight / 3;

  double get marqueeTextHeight => songBarHeight / 5;

  double get songBarWidth => mediaWidth - (songBarHeight * 2);

  double get fontSize => mediaHeight / 36;

  double get iconSize => mediaHeight / 28;

  Future<T?> showHorizontalDialog<T>(Widget dialog) {
    return showModalBottomSheet<T>(
      elevation: 0,
      context: this,
      barrierColor: Colors.transparent,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: horizontalCubit),
          BlocProvider.value(value: horiverticalCubit),
        ],
        child: dialog,
      ),
    );
  }
}
