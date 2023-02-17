import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:src/exports/widgets.dart';

import '/pages/horivertical/horivertical_widget.dart';

part '../../widgets/horizontal/buttons/horizontal_elevated_button.dart';
part '../../widgets/horizontal/buttons/horizontal_outlined_button.dart';
part '../../widgets/horizontal/horizontal_marquee_text.dart';

extension HorizontalWidgetX on BuildContext {
  double get songBarHeight => mediaHeight * 0.2;

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

  void showHorizontalDialog(Widget dialog) async {
    await showModalBottomSheet(
      elevation: 0,
      context: this,
      barrierColor: Colors.transparent,
      builder: (_) => BlocProvider.value(value: playerCubit, child: dialog),
    );
  }
}


// enum HorizontalDialogType {
//   about,
//   account,
//   chat,
//   help,
//   icon,
//   menu,
//   song,
//   volume,
//   vote,
//   ;
// }

// class HorizontalDialogCubit extends Cubit<HorizontalDialogState> {
//   HorizontalDialogCubit() : super(HorizontalDialogState.initial());

//   void pop() => emit(state.copyWith(type: HorizontalDialogType.menu));

//   void push(HorizontalDialogType type) => emit(state.copyWith(type: type));
// }

// class HorizontalDialogState {
//   final HorizontalDialogType type;

//   const HorizontalDialogState._({
//     required this.type,
//   });

//   factory HorizontalDialogState.initial() {
//     return const HorizontalDialogState._(
//       type: HorizontalDialogType.menu,
//     );
//   }

//   HorizontalDialogState copyWith({
//     HorizontalDialogType? type,
//   }) {
//     return HorizontalDialogState._(
//       type: type ?? this.type,
//     );
//   }
// }

// class HorizontalDialog extends StatelessWidget {
//   const HorizontalDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HorizontalDialogCubit, HorizontalDialogState>(
//       builder: (context, state) {
//         switch (state.type) {
//           case HorizontalDialogType.about:
//             return const HorizontalAboutDialog();
//           case HorizontalDialogType.account:
//             return const HorizontalAccountDialog();
//           case HorizontalDialogType.chat:
//             return const HorizontalChatDialog();
//           case HorizontalDialogType.help:
//             return const HorizontalHelpDialog();
//           case HorizontalDialogType.icon:
//             return const HorizontalIconDialog();
//           case HorizontalDialogType.menu:
//             return const HorizontalMenuDialog();
//           case HorizontalDialogType.song:
//             return const HorizontalVolumeDialog();
//           case HorizontalDialogType.volume:
//             return const HorizontalVolumeDialog();
//           case HorizontalDialogType.vote:
//             return const HorizontalVoteDialog();
//         }
//       },
//     );
//   }
// }
