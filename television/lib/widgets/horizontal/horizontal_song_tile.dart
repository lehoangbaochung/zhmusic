import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/widgets.dart';

import '/pages/horizontal/horizontal_dialog.dart';
import '/pages/horizontal/horizontal_widget.dart';

class HorizontalSongTile extends StatelessWidget {
  const HorizontalSongTile(this.song, {super.key});

  final YoutubeMusic song;

  @override
  Widget build(BuildContext context) {
    final previewing = ValueNotifier(false);
    return SizedBox.square(
      dimension: context.songBarHeight,
      child: ValueListenableBuilder(
        valueListenable: previewing,
        child: Image.network(
          fit: BoxFit.cover,
          song.getImageUrl(YoutubeThumbnail.hqdefault),
        ),
        builder: (context, value, child) {
          return InkWell(
            onHover: (value) => previewing.value = value,
            onFocusChange: (value) => previewing.value = value,
            onHighlightChanged: (value) => previewing.value = value,
            onTap: () => context.showHorizontalDialog(HorizontalSongDialog(song)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                child!,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Visibility(
                    visible: previewing.value,
                    child: Container(
                      color: Colors.green,
                      width: context.songBarHeight,
                      padding: EdgeInsets.all(context.songBarHeight / 32),
                      child: Text(
                        song.getName(MusicLanguage.vi),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: context.mediaHeight / 48,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
