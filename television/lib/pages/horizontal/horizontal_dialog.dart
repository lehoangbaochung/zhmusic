import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/widgets.dart';
import 'package:television/pages/horivertical/horivertical_page.dart';

import '/app/app_storage.dart';
import '/pages/horivertical/horivertical_widget.dart';
import '/pages/horizontal/horizontal_widget.dart';
import '/widgets/horizontal/dialogs/horizontal_subtitle_dialog.dart';
import '/widgets/horizontal/dialogs/horizontal_theme_dialog.dart';
import '/widgets/horizontal/horizontal_song_tile.dart';

part '../../widgets/horizontal/dialogs/horizontal_about_dialog.dart';
part '../../widgets/horizontal/dialogs/horizontal_account_dialog.dart';
part '../../widgets/horizontal/dialogs/horizontal_chat_dialog.dart';
part '../../widgets/horizontal/dialogs/horizontal_favorite_dialog.dart';
part '../../widgets/horizontal/dialogs/horizontal_help_dialog.dart';
part '../../widgets/horizontal/dialogs/horizontal_icon_dialog.dart';
part '../../widgets/horizontal/dialogs/horizontal_menu_dialog.dart';
part '../../widgets/horizontal/dialogs/horizontal_player_dialog.dart';
part '../../widgets/horizontal/dialogs/horizontal_playlist_dialog.dart';
part '../../widgets/horizontal/dialogs/horizontal_song_dialog.dart';
part '../../widgets/horizontal/dialogs/horizontal_volume_dialog.dart';
part '../../widgets/horizontal/dialogs/horizontal_vote_dialog.dart';

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
          AbsorbPointer(child: leading),
          Expanded(child: child),
          trailing,
        ],
      ),
    );
  }
}
