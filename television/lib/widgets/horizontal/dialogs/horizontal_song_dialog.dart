part of '/pages/horizontal/horizontal_dialog.dart';

class HorizontalSongDialog extends StatelessWidget {
  const HorizontalSongDialog(this.song, {super.key});

  final YoutubeMusic song;

  @override
  Widget build(BuildContext context) {
    return HorizontalDialog.normal(
      leading: HorizontalElevatedButton(
        icon: Icons.music_note,
        label: 'Bài hát',
        onPressed: () => Navigator.pop(context),
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
                context.playerCubit.vote(song);
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
                  HorizontalDialog.normal(
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
                          return IgnorePointer(
                            child: Row(
                              children: [
                                // view
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      shape: const MaterialStatePropertyAll(
                                        RoundedRectangleBorder(),
                                      ),
                                      fixedSize: MaterialStatePropertyAll(
                                        Size.fromWidth(context.songBarHeight),
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${metadata.viewCount}',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontSize: context.mediaHeight / 36,
                                            ),
                                          ),
                                          Text(
                                            'Lượt nghe',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontSize: context.mediaHeight / 36,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // like
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      shape: const MaterialStatePropertyAll(
                                        RoundedRectangleBorder(),
                                      ),
                                      fixedSize: MaterialStatePropertyAll(
                                        Size.fromWidth(context.songBarHeight),
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${metadata.likeCount}',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontSize: context.mediaHeight / 36,
                                            ),
                                          ),
                                          Text(
                                            'Lượt thích',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontSize: context.mediaHeight / 36,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // duration
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      shape: const MaterialStatePropertyAll(
                                        RoundedRectangleBorder(),
                                      ),
                                      fixedSize: MaterialStatePropertyAll(
                                        Size.fromWidth(context.songBarHeight),
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${metadata.duration?.format()}',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontSize: context.mediaHeight / 36,
                                            ),
                                          ),
                                          Text(
                                            'Thời lượng',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontSize: context.mediaHeight / 36,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // upload
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      shape: const MaterialStatePropertyAll(
                                        RoundedRectangleBorder(),
                                      ),
                                      fixedSize: MaterialStatePropertyAll(
                                        Size.fromWidth(context.songBarHeight),
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${metadata.uploadDate?.format()}',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontSize: context.mediaHeight / 36,
                                            ),
                                          ),
                                          Text(
                                            'Ngày tải lên',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontSize: context.mediaHeight / 36,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // publish
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      shape: const MaterialStatePropertyAll(
                                        RoundedRectangleBorder(),
                                      ),
                                      fixedSize: MaterialStatePropertyAll(
                                        Size.fromWidth(context.songBarHeight),
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${metadata.uploadDate?.format()}',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontSize: context.mediaHeight / 36,
                                            ),
                                          ),
                                          Text(
                                            'Ngày đăng tải',
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontSize: context.mediaHeight / 36,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
    );
  }
}
