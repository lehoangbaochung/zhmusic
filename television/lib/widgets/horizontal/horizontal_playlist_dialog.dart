part of '/pages/horizontal/horizontal_widget.dart';

class HorizontalPlaylistDialog extends StatelessWidget {
  const HorizontalPlaylistDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final mainCubit = context.read<MainCubit>();
    final mainState = context.watch<MainCubit>().state;
    return BlocBuilder(
      bloc: mainCubit,
      builder: (context, state) {
        return SizedBox(
          height: context.songBarHeight,
          child: Row(
            children: [
              // Leading button.
              HorizontalIconButton(
                icon: Icons.refresh,
                text: 'Làm mới',
                onPressed: () {
                  mainCubit.refresh();
                },
              ),
              // playlist
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: mainState.playlist.length,
                  itemBuilder: (context, index) {
                    final song = mainState.playlist.elementAt(index);
                    return SizedBox.square(
                      dimension: context.songBarHeight,
                      child: InkWell(
                        child: Image.network(
                          fit: BoxFit.cover,
                          width: context.songBarHeight,
                          height: context.songBarHeight,
                          song.getImageUrl(
                            YoutubeThumbnail.hqdefault,
                          ),
                        ),
                        onTap: () async {
                          await showModalBottomSheet(
                            context: context,
                            builder: (_) => SizedBox(
                              height: context.songBarHeight,
                              child: Row(
                                children: [
                                  // Leading button.
                                  HorizontalIconButton(
                                    icon: Icons.arrow_back,
                                    text: 'Quay lại',
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  const VerticalDivider(
                                    color: Colors.black,
                                  ),
                                  // Song detail.
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: mainState.playlist.length,
                                      itemBuilder: (context, index) {
                                        final song = mainState.playlist.elementAt(index);
                                        return ListTile(
                                          leading: const SizedBox(
                                            height: double.infinity,
                                            child: Icon(Icons.music_note),
                                          ),
                                          title: Text(
                                            song.getName(MusicLanguage.vi),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          subtitle: FutureBuilder(
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
                                        );
                                      },
                                    ),
                                  ),
                                  const VerticalDivider(),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: mainState.playlist.length,
                                      itemBuilder: (context, index) {
                                        final song = mainState.playlist.elementAt(index);
                                        return ListTile(
                                          leading: const SizedBox(
                                            height: double.infinity,
                                            child: Icon(Icons.music_note),
                                          ),
                                          title: Text(
                                            song.getName(MusicLanguage.vi),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          subtitle: FutureBuilder(
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
                                        );
                                      },
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: Colors.black,
                                  ),
                                  // Trailing button.
                                  const HorizontalIconButton(
                                    icon: Icons.how_to_vote,
                                    text: 'Bình chọn',
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              // Trailing button.
              const HorizontalIconButton(
                icon: Icons.how_to_vote,
                text: 'Bình chọn',
              ),
            ],
          ),
        );
      },
    );
  }
}
