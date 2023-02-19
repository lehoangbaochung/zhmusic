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
        itemCount: playlist.keys.length,
        itemBuilder: (context, index) {
          return HorizontalSongTile(
            playlist.keys.elementAt(index),
          );
        },
      ),
    );
  }
}
