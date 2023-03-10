import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:television/app/app_storage.dart';
import 'package:television/pages/horizontal/horizontal_dialog.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

class HorizontalFavoriteDialog extends StatelessWidget {
  const HorizontalFavoriteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalDialog(
      leading: HorizontalPrimaryTile.icon(
        icon: Icons.favorite,
        label: 'Yêu thích',
        onPressed: () {},
      ),
      trailing: HorizontalPrimaryTile.icon(
        icon: Icons.arrow_back,
        label: 'Quay lại',
        onPressed: () => Navigator.pop(context),
      ),
      child: StatefulBuilder(
        builder: (context, setState) {
          return FutureBuilder(
            future: appStorage.getFavoriteSongs(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final songs = snapshot.requireData;
                return songs.isEmpty
                    ? Text(
                        'Hiện không có bài hát nào trong danh sách này',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: context.fontSize,
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: songs.length,
                        itemBuilder: (context, index) {
                          final song = songs.elementAt(index);
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
                                  onTap: () => context.showHorizontalDialog(HorizontalSongDialog(song)).then((_) => setState(() {})),
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
                        },
                      );
              }
              return centeredLoadingIndicator;
            },
          );
        },
      ),
    );
  }
}
