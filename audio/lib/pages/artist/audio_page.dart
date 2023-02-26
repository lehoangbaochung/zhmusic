part of 'artist_page.dart';

class ArtistProvider extends InheritedWidget {
  const ArtistProvider({
    super.key,
    required this.artist,
    required super.child,
  });

  final Artist artist;

  @override
  bool updateShouldNotify(ArtistProvider oldWidget) => artist != oldWidget.artist;

  static ArtistProvider of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<ArtistProvider>()!;
}

class AudioFragment extends StatelessWidget {
  const AudioFragment({super.key});

  @override
  Widget build(BuildContext context) {
    final artist = ArtistProvider.of(context).artist;
    return FutureBuilder(
      future: artist.getAudios(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final audios = snapshot.requireData;
          return audios.isEmpty
              ? Center(
                  child: Text(
                    'Trống',
                    style: context.textTheme.titleMedium,
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.getWidth(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.play_circle),
                            label: Text(
                              'Phát tất cả',
                              style: context.textTheme.titleMedium,
                            ),
                          ),
                          DropdownButton(
                            value: 1,
                            underline: placeholder,
                            borderRadius: BorderRadius.circular(8),
                            items: const [
                              DropdownMenuItem(
                                value: 0,
                                child: Text('Mới nhất'),
                              ),
                              DropdownMenuItem(
                                value: 1,
                                child: Text('Được nghe nhiều nhất'),
                              ),
                            ],
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: audios.length,
                        itemBuilder: (context, index) {
                          final audio = audios.elementAt(index);
                          return ListTile(
                            contentPadding: EdgeInsets.only(left: context.getWidth(8)),
                            title: Text(
                              audio.getName(MusicLanguage.vi),
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: FutureBuilder(
                              future: audio.getArtists(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final artists = snapshot.requireData;
                                  return Text(
                                    artists.getName(MusicLanguage.vi),
                                    overflow: TextOverflow.ellipsis,
                                  );
                                }
                                return placeholder;
                              },
                            ),
                            leading: Container(
                              width: context.getWidth(30),
                              height: context.getWidth(40),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    audio.getImageUrl(),
                                  ),
                                ),
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.playlist_add),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.more_vert),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
        }
        return centeredLoadingIndicator;
      },
    );
  }
}
