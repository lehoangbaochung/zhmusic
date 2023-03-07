import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:television/pages/horivertical/horivertical_widget.dart';
import 'package:television/pages/horizontal/horizontal_dialog.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

import '../horizontal_song_tile.dart';

class HorizontalVoteDialog extends StatelessWidget {
  const HorizontalVoteDialog({
    super.key,
    this.songs,
  });

  final Iterable<YoutubeMusic>? songs;

  @override
  Widget build(BuildContext context) {
    final songs = this.songs ?? context.horiverticalState.library.shuffled;
    return HorizontalDialog(
      leading: HorizontalPrimaryTile.icon(
        icon: Icons.how_to_vote,
        label: 'Bình chọn',
        onPressed: () {},
      ),
      trailing: HorizontalPrimaryTile.icon(
        icon: Icons.arrow_back,
        label: 'Quay lại',
        onPressed: () => Navigator.pop(context),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return HorizontalSongTile(
            songs.elementAt(index),
          );
        },
      ),
    );
  }
}
