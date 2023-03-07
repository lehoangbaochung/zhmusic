import 'package:flutter/material.dart';
import '/pages/horizontal/horizontal_widget.dart';

export '../../widgets/horizontal/dialogs/horizontal_about_dialog.dart';
export '../../widgets/horizontal/dialogs/horizontal_account_dialog.dart';
export '../../widgets/horizontal/dialogs/horizontal_chat_dialog.dart';
export '../../widgets/horizontal/dialogs/horizontal_favorite_dialog.dart';
export '../../widgets/horizontal/dialogs/horizontal_help_dialog.dart';
export '../../widgets/horizontal/dialogs/horizontal_icon_dialog.dart';
export '../../widgets/horizontal/dialogs/horizontal_menu_dialog.dart';
export '../../widgets/horizontal/dialogs/horizontal_player_dialog.dart';
export '../../widgets/horizontal/dialogs/horizontal_playlist_dialog.dart';
export '../../widgets/horizontal/dialogs/horizontal_song_dialog.dart';
export '../../widgets/horizontal/dialogs/horizontal_volume_dialog.dart';
export '../../widgets/horizontal/dialogs/horizontal_vote_dialog.dart';

class HorizontalDialog extends StatelessWidget {
  const HorizontalDialog({
    super.key,
    required this.leading,
    required this.trailing,
    required this.child,
  });

  final Widget leading;
  final Widget trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.songBarHeight,
      child: Row(
        children: [
          ExcludeFocus(
            child: AbsorbPointer(child: leading),
          ),
          Expanded(child: child),
          trailing,
        ],
      ),
    );
  }
}
