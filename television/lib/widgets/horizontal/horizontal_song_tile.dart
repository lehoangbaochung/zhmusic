part of '/pages/horizontal/horizontal_widget.dart';

class HorizontalSongTile extends StatelessWidget {
  const HorizontalSongTile(this.song, {super.key});

  final YoutubeMusic song;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // song vote
          const LinearProgressIndicator(
            value: 0.1,
            minHeight: 20,
            color: Colors.lightGreen,
            backgroundColor: Colors.transparent,
          ),
          // song name
          Text(
            song.getName(MusicLanguage.vi),
            overflow: TextOverflow.ellipsis,
          ),
          // artist name
          FutureBuilder(
            future: song.getArtists(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final artists = snapshot.requireData;
                return Text(
                  artists.getName(MusicLanguage.vi),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                );
              }
              return emptyPlaceholder;
            },
          ),
        ],
      ),
      onTap: () async {
        await showModalBottomSheet(
          context: context,
          builder: (_) => HorizontalSongDialog(song),
        );
      },
    );
  }
}
