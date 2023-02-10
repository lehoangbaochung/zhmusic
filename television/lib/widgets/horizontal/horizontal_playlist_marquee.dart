part of '/pages/horizontal/horizontal_widget.dart';

class HorizontalPlaylistMarquee extends StatelessWidget {
  const HorizontalPlaylistMarquee({super.key});

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();
    return SizedBox(
      height: 80,
      child: InkWell(
        child: FutureBuilder(
          future: Future.wait(
            mainCubit.state.playlist.map((song) async {
              final artists = await song.getArtists();
              final name = song.getName(MusicLanguage.vi);
              final artistsName = artists.getName(MusicLanguage.vi, separator: ' & ');
              return artists.isNotEmpty ? '$name - $artistsName' : name;
            }),
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Marquee(
                text: snapshot.requireData.join('; '),
                style: marqueeTextStyle,
                velocity: 150,
                blankSpace: context.mediaWidth,
                pauseAfterRound: const Duration(seconds: 1),
              );
            }
            return emptyPlaceholder;
          },
        ),
        onTap: () async {
          await showModalBottomSheet(
            context: context,
            builder: (_) => BlocProvider.value(
              value: mainCubit,
              child: const HorizontalPlaylistDialog(),
            ),
          );
        },
      ),
    );
  }
}
