part of '/pages/horizontal/horizontal_dialog.dart';

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
              return Text(
                '$songName - $artistsName',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: context.fontSize,
                  fontWeight: FontWeight.bold,
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
              imageUrl: song.getImageUrl(YoutubeThumbnail.hqdefault),
            ),
          ),
          trailing: HorizontalElevatedButton(
            icon: Icons.arrow_back,
            label: 'Quay lại',
            onPressed: () => Navigator.pop(context),
          ),
          child: Row(
            children: [
              Expanded(
                child: HorizontalOutlinedButton.large(
                  icon: Icons.how_to_vote,
                  label: 'Bình chọn',
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
                          return HorizontalOutlinedButton.large(
                            icon: unsaved ? Icons.favorite_border : Icons.favorite,
                            label: unsaved ? 'Yêu thích' : 'Đã lưu',
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
                child: HorizontalOutlinedButton.large(
                  icon: Icons.list_alt,
                  label: 'Chi tiết',
                  onPressed: () {
                    context.showHorizontalDialog(
                      HorizontalDialog(
                        leading: HorizontalElevatedButton(
                          icon: Icons.list_alt,
                          label: 'Chi tiết',
                          onPressed: () {},
                        ),
                        trailing: HorizontalElevatedButton(
                          icon: Icons.arrow_back,
                          label: 'Quay lại',
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
                                    child: HorizontalOutlinedTile(
                                      title: '${metadata.viewCount}',
                                      subtitle: 'Lượt nghe',
                                    ),
                                  ),
                                  Expanded(
                                    child: HorizontalOutlinedTile(
                                      title: '${metadata.likeCount}',
                                      subtitle: 'Lượt thích',
                                    ),
                                  ),
                                  Expanded(
                                    child: HorizontalOutlinedTile(
                                      title: '${metadata.duration?.format()}',
                                      subtitle: 'Thời lượng',
                                    ),
                                  ),
                                  Expanded(
                                    child: HorizontalOutlinedTile(
                                      title: '${metadata.uploadDate?.format()}',
                                      subtitle: 'Ngày tải lên',
                                    ),
                                  ),
                                  Expanded(
                                    child: HorizontalOutlinedTile(
                                      title: '${metadata.publishDate?.format()}',
                                      subtitle: 'Ngày đăng tải',
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
