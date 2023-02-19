part of 'main_page.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: musicStorage.getArtists(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final artists = snapshot.requireData.shuffled;
            return ListView.builder(
              itemCount: artists.length,
              itemBuilder: (context, index) {
                final artist = artists.elementAt(index);
                return FutureBuilder(
                  future: artist.getShorts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final shorts = snapshot.requireData.shuffled;
                      return shorts.isEmpty
                          ? emptyPlaceholder
                          : Column(
                              children: [
                                ListTile(
                                  tileColor: context.primaryColor,
                                  textColor: context.backgroundColor,
                                  iconColor: context.backgroundColor,
                                  title: Text(
                                    artist.getName(MusicLanguage.vi),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text('${shorts.length} video'),
                                  leading: CachedNetworkImage(
                                    imageUrl: artist.getImageUrl(),
                                    imageBuilder: (_, imageProvider) {
                                      return CircleAvatar(
                                        backgroundImage: imageProvider,
                                      );
                                    },
                                    placeholder: (_, __) {
                                      return const CircleAvatar(
                                        child: Icon(Icons.person),
                                      );
                                    },
                                    errorWidget: (_, __, ___) {
                                      return const CircleAvatar(
                                        child: Icon(Icons.error),
                                      );
                                    },
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                ),
                                SizedBox(
                                  height: context.mediaHeight / 3,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: shorts.length,
                                    itemBuilder: (context, index) {
                                      return ShortGridTile(
                                        index: index,
                                        shorts: shorts,
                                      );
                                    },
                                    separatorBuilder: (_, __) {
                                      return const SizedBox(width: 1);
                                    },
                                  ),
                                ),
                              ],
                            );
                    }
                    return centeredLoadingIndicator;
                  },
                );
              },
            );
          }
          return centeredLoadingIndicator;
        },
      ),
    );
  }
}
