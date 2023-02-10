part of '/pages/horizontal/horizontal_widget.dart';

class HorizontalSongDialog extends StatelessWidget {
  const HorizontalSongDialog(this.song, {super.key});

  final YoutubeMusic song;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.songBarHeight,
      child: Row(
        children: [
          // leading
          HorizontalIconButton(
            icon: Icons.arrow_back,
            text: 'Quay lại',
            onPressed: () => Navigator.pop(context),
          ),
          // detail
          Expanded(
            child: ListTile(
              title: FutureBuilder(
                future: song.getArtists(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final artists = snapshot.requireData;
                    return Text(
                      artists.getName(MusicLanguage.vi),
                      overflow: TextOverflow.ellipsis,
                    );
                  }
                  return emptyPlaceholder;
                },
              ),
            ),
          ),
          // trailing
          const HorizontalIconButton(
            icon: Icons.how_to_vote,
            text: 'Bình chọn',
          ),
        ],
      ),
    );
  }
}
