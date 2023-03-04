import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';

import '/pages/horivertical/horivertical_widget.dart';
import '/pages/horizontal/horizontal_dialog.dart';
import '/pages/horizontal/horizontal_widget.dart';
import 'horizontal_playlist_text.dart';

class HorizontalSongBar extends StatelessWidget {
  const HorizontalSongBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.horiverticalState.theme;
    final playlist = context.horiverticalState.playlist;
    return Container(
      height: context.songBarHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          image: CachedNetworkImageProvider(theme.backgroundUrl),
        ),
      ),
      child: Row(
        children: [
          SizedBox.square(
            dimension: context.songBarHeight,
            child: IconButton(
              tooltip: 'Menu',
              autofocus: true,
              padding: EdgeInsets.zero,
              icon: MusicType.audio.image,
              onPressed: () async {
                await context.showHorizontalDialog(
                  const HorizontalMenuDialog(),
                );
              },
            ),
          ),
          Expanded(
            child: Column(
              children: [
                // songs
                Row(
                  children: playlist.keys.take(3).map(
                    (song) {
                      final height = context.songBarHeight * .6;
                      final index = playlist.keys.toList().indexOf(song);
                      final songVote = playlist.values.elementAt(index).length + 1;
                      final voteCount = playlist.values.map((account) => account.length).reduce((value, element) => value + element + 1);
                      return Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            fixedSize: Size.fromHeight(height),
                            padding: EdgeInsets.symmetric(
                              horizontal: context.mediaWidth / 128,
                            ),
                          ),
                          onPressed: () {
                            context.showHorizontalDialog(
                              HorizontalSongDialog(song),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // song vote
                              LinearProgressIndicator(
                                value: songVote / voteCount,
                                minHeight: height / 6,
                                color: theme.songVoteColor,
                                backgroundColor: Colors.transparent,
                              ),
                              // song name
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: context.mediaHeight / 256,
                                ),
                                child: Text(
                                  song.getName(MusicLanguage.vi),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: theme.songTextColor,
                                    fontSize: context.fontSize,
                                  ),
                                ),
                              ),
                              // artist name
                              FutureBuilder(
                                future: song.getArtists(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final artists = snapshot.requireData;
                                    return Text(
                                      artists.getName(MusicLanguage.vi),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: theme.songTextColor,
                                        fontSize: context.fontSize,
                                      ),
                                    );
                                  }
                                  return placeholder;
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
                // playlist
                const HorizontalPlaylistText(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
