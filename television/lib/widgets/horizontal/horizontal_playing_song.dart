part of '/pages/horizontal/horizontal_widget.dart';

class HorizontalPlayingSong extends StatelessWidget {
  const HorizontalPlayingSong(this.song, {super.key});

  final YoutubeMusic song;

  Future<String> get playingSongDetail async {
    final artists = await song.getArtists();
    final name = song.getName(MusicLanguage.vi);
    final artistsName = artists.getName(MusicLanguage.vi, separator: ' & ');
    return artists.isNotEmpty ? 'Đang phát: $name\nThể hiện: $artistsName' : 'Đang phát: $name';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(50),
      alignment: Alignment.centerLeft,
      child: InkWell(
        child: FutureBuilder(
          future: playingSongDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.requireData,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              );
            }
            return emptyPlaceholder;
          },
        ),
        onTap: () async {
          await showModalBottomSheet(
            context: context,
            builder: (_) => HorizontalSongDialog(song),
          );
        },
      ),
    );
  }
}
