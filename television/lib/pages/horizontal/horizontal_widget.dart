import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/widgets.dart';

import '/app/app_colors.dart';
import '/pages/main/main_page.dart';

part '../../widgets/horizontal/buttons/horizontal_elevated_button.dart';
part '../../widgets/horizontal/buttons/horizontal_outlined_button.dart';
part '../../widgets/horizontal/dialogs/horizontal_about_dialog.dart';
part '../../widgets/horizontal/dialogs/horizontal_account_dialog.dart';
part '../../widgets/horizontal/dialogs/horizontal_chat_dialog.dart';
part '../../widgets/horizontal/dialogs/horizontal_help_dialog.dart';
part '../../widgets/horizontal/dialogs/horizontal_icon_dialog.dart';
part '../../widgets/horizontal/dialogs/horizontal_song_dialog.dart';
part '../../widgets/horizontal/dialogs/horizontal_vote_dialog.dart';
part '../../widgets/horizontal/horizontal_bottom_sheet.dart';
part '../../widgets/horizontal/horizontal_marquee_text.dart';

extension HorizontalWidgetX on BuildContext {
  MainCubit get mainCubit => read<MainCubit>();

  MainState get mainState => watch<MainCubit>().state;

  double get songBarHeight => mediaHeight * 0.18;

  double get songTextHeight => songBarHeight / 3;

  double get marqueeTextHeight => songBarHeight / 4.5;
}

const songTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

const marqueeTextStyle = TextStyle(
  fontSize: 28,
  color: Colors.white,
);
