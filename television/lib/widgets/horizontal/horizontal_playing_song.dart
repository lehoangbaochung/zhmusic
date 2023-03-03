import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';

import '/pages/horivertical/horivertical_widget.dart';
import '/pages/horizontal/horizontal_dialog.dart';
import '/pages/horizontal/horizontal_widget.dart';

class HorizontalPlayingSong extends StatelessWidget {
  const HorizontalPlayingSong({super.key});

  @override
  Widget build(BuildContext context) {
    final playingSong = context.horiverticalState.playingSong;
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: context.mediaHeight / 16,
          horizontal: context.mediaWidth / 16,
        ),
      ),
      onPressed: () {
        context.showHorizontalDialog(
          HorizontalSongDialog(playingSong),
        );
      },
      child: FutureBuilder(
        future: Future.sync(() async {
          final artists = await playingSong.getArtists();
          final name = playingSong.getName(MusicLanguage.vi);
          final artistsName = artists.getName(MusicLanguage.vi, separator: ' & ');
          return artists.isNotEmpty ? 'Đang phát: $name\nThể hiện: $artistsName' : 'Đang phát: $name';
        }),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              snapshot.requireData,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: context.fontSize,
                background: Paint()
                  ..strokeWidth = 1
                  ..style = PaintingStyle.fill
                  ..color = Colors.black.withOpacity(.6),
                foreground: Paint()
                  ..strokeWidth = 1
                  ..style = PaintingStyle.fill
                  ..color = Colors.white,
              ),
            );
          }
          return placeholder;
        },
      ),
    );
  }
}
