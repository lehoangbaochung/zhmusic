part of '/pages/horizontal/horizontal_dialog.dart';

class HorizontalPlaylistDialog extends StatelessWidget {
  const HorizontalPlaylistDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final playlist = context.playerState.playlist;
    return HorizontalDialog.normal(
      leading: HorizontalElevatedButton(
        icon: Icons.playlist_play,
        label: 'Playlist',
        onPressed: () {},
      ),
      trailing: HorizontalElevatedButton(
        icon: Icons.close,
        label: 'Đóng',
        onPressed: () => Navigator.pop(context),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: playlist.length,
        itemBuilder: (context, index) {
          final song = playlist.keys.elementAt(index);
          return InkWell(
            child: Tooltip(
              message: song.getName(MusicLanguage.vi),
              child: SizedBox.square(
                dimension: context.songBarHeight,
                child: Image.network(
                  fit: BoxFit.cover,
                  song.getImageUrl(
                    YoutubeThumbnail.hqdefault,
                  ),
                ),
              ),
            ),
            onTap: () async {
              await showModalBottomSheet(
                context: context,
                builder: (_) => HorizontalSongDialog(song, 0),
              );
            },
          );
        },
      ),
    );
  }
}
