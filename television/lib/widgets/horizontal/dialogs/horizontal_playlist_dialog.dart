import 'package:flutter/material.dart';
import 'package:television/pages/horivertical/horivertical_widget.dart';
import 'package:television/pages/horizontal/horizontal_dialog.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';
import 'package:television/widgets/horizontal/horizontal_song_tile.dart';

class HorizontalPlaylistDialog extends StatelessWidget {
  const HorizontalPlaylistDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final playlist = context.horiverticalState.playlist;
    return HorizontalDialog(
      leading: HorizontalPrimaryTile.icon(
        icon: Icons.playlist_play,
        label: 'Playlist',
        onPressed: () {},
      ),
      trailing: HorizontalPrimaryTile.icon(
        icon: Icons.close,
        label: 'Đóng',
        onPressed: () => Navigator.pop(context),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: playlist.keys.length,
        itemBuilder: (context, index) {
          return HorizontalSongTile(
            playlist.keys.elementAt(index),
          );
        },
      ),
    );
  }
}
