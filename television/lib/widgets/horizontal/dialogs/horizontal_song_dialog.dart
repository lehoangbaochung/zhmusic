import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:television/app/app_storage.dart';
import 'package:television/pages/horivertical/horivertical_widget.dart';
import 'package:television/pages/horizontal/horizontal_dialog.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

import '../horizontal_secondary_tile.dart';

class HorizontalSongDialog extends StatelessWidget {
  const HorizontalSongDialog(this.song, {super.key});

  final YoutubeMusic song;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FutureBuilder(
          future: song.getArtists(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final artists = snapshot.requireData;
              final songName = song.getName(MusicLanguage.vi);
              final artistsName = artists.getName(MusicLanguage.vi);
              return Container(
                width: context.mediaWidth,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.lightGreen,
                      Colors.green,
                      Colors.lightGreen,
                      Colors.white,
                    ],
                  ),
                ),
                child: Text(
                  '$songName - $artistsName',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: context.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return placeholder;
          },
        ),
        HorizontalDialog(
          leading: SizedBox.square(
            dimension: context.songBarHeight,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: song.getImageUrl(
                YoutubeThumbnail.hqdefault,
              ),
            ),
          ),
          trailing: HorizontalPrimaryTile.icon(
            icon: Icons.arrow_back,
            label: 'Quay l???i',
            onPressed: () => Navigator.pop(context),
          ),
          child: Row(
            children: [
              Expanded(
                child: HorizontalSecondaryTile.icon(
                  icon: Icons.how_to_vote,
                  label: 'B??nh ch???n',
                  onPressed: () {
                    Navigator.pop(context);
                    context.horiverticalCubit.vote(song);
                  },
                ),
              ),
              Expanded(
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return FutureBuilder(
                      future: appStorage.getFavoriteSongs(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final songs = snapshot.requireData.toList();
                          final unsaved = !songs.contains(song);
                          return HorizontalSecondaryTile.icon(
                            icon: unsaved ? Icons.favorite_border : Icons.favorite,
                            label: unsaved ? 'Y??u th??ch' : '???? l??u',
                            onPressed: () async {
                              if (unsaved) {
                                await appStorage.setFavoriteSongs(songs..add(song));
                              } else {
                                await appStorage.setFavoriteSongs(songs..remove(song));
                              }
                              setState(() {});
                            },
                          );
                        }
                        return centeredLoadingIndicator;
                      },
                    );
                  },
                ),
              ),
              Expanded(
                child: HorizontalSecondaryTile.icon(
                  icon: Icons.list_alt,
                  label: 'Chi ti???t',
                  onPressed: () {
                    context.showHorizontalDialog(
                      HorizontalDialog(
                        leading: HorizontalPrimaryTile.icon(
                          icon: Icons.list_alt,
                          label: 'Chi ti???t',
                          onPressed: () {},
                        ),
                        trailing: HorizontalPrimaryTile.icon(
                          icon: Icons.arrow_back,
                          label: 'Quay l???i',
                          onPressed: () => Navigator.pop(context),
                        ),
                        child: FutureBuilder(
                          future: song.getMetadata(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final metadata = snapshot.requireData;
                              return Row(
                                children: [
                                  Expanded(
                                    child: HorizontalSecondaryTile.text(
                                      title: '${metadata.viewCount}',
                                      subtitle: 'L?????t nghe',
                                    ),
                                  ),
                                  Expanded(
                                    child: HorizontalSecondaryTile.text(
                                      title: '${metadata.likeCount}',
                                      subtitle: 'L?????t th??ch',
                                    ),
                                  ),
                                  Expanded(
                                    child: HorizontalSecondaryTile.text(
                                      title: '${metadata.duration?.format()}',
                                      subtitle: 'Th???i l?????ng',
                                    ),
                                  ),
                                  Expanded(
                                    child: HorizontalSecondaryTile.text(
                                      title: '${metadata.uploadDate?.format()}',
                                      subtitle: 'Ng??y t???i l??n',
                                    ),
                                  ),
                                  Expanded(
                                    child: HorizontalSecondaryTile.text(
                                      title: '${metadata.publishDate?.format()}',
                                      subtitle: 'Ng??y ????ng t???i',
                                    ),
                                  ),
                                ],
                              );
                            }
                            return centeredLoadingIndicator;
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
