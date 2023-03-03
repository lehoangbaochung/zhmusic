import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:television/pages/horivertical/horivertical_widget.dart';
import 'package:television/pages/horizontal/horizontal_dialog.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

class HorizontalPlaylistText extends StatelessWidget {
  const HorizontalPlaylistText({super.key});

  @override
  Widget build(BuildContext context) {
    final playlist = context.horiverticalState.playlist;
    return FutureBuilder(
      future: Future.wait(
        playlist.keys.map((song) async {
          final artists = await song.getArtists();
          final name = song.getName(MusicLanguage.vi);
          final artistsName = artists.getName(MusicLanguage.vi, separator: ' & ');
          return artists.isNotEmpty ? '$name - $artistsName' : name;
        }),
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: HorizontalMarqueeText(
              text: snapshot.requireData.join('; '),
              onPressed: () async {
                context.showHorizontalDialog(
                  const HorizontalPlaylistDialog(),
                );
              },
            ),
          );
        }
        return placeholder;
      },
    );
  }
}