import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shorts/app/app_colors.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/widgets.dart';

import '/app/app_pages.dart';
import '/widgets/short_grid_tile.dart';

class ArtistPage extends StatelessWidget {
  const ArtistPage(this.artist, {super.key});

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              final buttonStyle = ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  context.backgroundColor,
                ),
                foregroundColor: MaterialStateProperty.all(
                  context.primaryColor,
                ),
              );
              return [
                SliverAppBar(
                  stretch: true,
                  floating: true,
                  expandedHeight: context.mediaSize.height / 2,
                  flexibleSpace: FlexibleSpaceBar(
                    background: ColoredBox(
                      color: AppColors.primaryColor.withOpacity(0.8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: artist.getImageUrl(),
                            imageBuilder: (_, imageProvider) {
                              return CircleAvatar(
                                backgroundImage: imageProvider,
                                radius: context.mediaSize.height / 12,
                              );
                            },
                            placeholder: (_, __) {
                              return CircleAvatar(
                                backgroundImage: MusicType.short.image.image,
                                radius: context.mediaSize.height / 12,
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  artist.getName(MusicLanguage.vi),
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.titleLarge,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  artist.getName(MusicLanguage.zhHans),
                                  overflow: TextOverflow.ellipsis,
                                  style: context.textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.star_border),
                                label: const Text('Theo dõi'),
                                style: buttonStyle,
                              ),
                              const SizedBox(width: 4),
                              ElevatedButton.icon(
                                onPressed: () async {},
                                icon: const Icon(Icons.share),
                                label: const Text('Chia sẻ'),
                                style: buttonStyle,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 8,
                            ),
                            child: Text(
                              artist.getDescription(MusicLanguage.vi),
                              maxLines: 3,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: context.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () async {
                        await showSearch(
                          context: context,
                          delegate: SearchPage(),
                        );
                      },
                    ),
                  ],
                ),
              ];
            },
            body: Column(
              children: [
                const Divider(height: 2),
                ColoredBox(
                  color: context.primaryColor,
                  child: TabBar(
                    indicatorColor: context.backgroundColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.music_note),
                      ),
                      Tab(
                        icon: Icon(Icons.video_collection),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      FutureBuilder(
                        future: artist.getAudios(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final audios = snapshot.requireData;
                            return audios.isEmpty
                                ? Center(
                                    child: Text(
                                      'Nghệ sĩ này hiện chưa có bài hát nào',
                                      style: context.textTheme.titleMedium,
                                    ),
                                  )
                                : ListView.builder(
                                    itemCount: audios.length,
                                    itemBuilder: (context, index) {
                                      final audio = audios.elementAt(index);
                                      return ListTile(
                                        title: Text(
                                          audio.getName(MusicLanguage.vi),
                                        ),
                                        subtitle: FutureBuilder(
                                          future: audios.first.getArtists(),
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
                                        leading: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: audio.getImageUrl(),
                                          imageBuilder: (_, imageProvider) {
                                            return CircleAvatar(
                                              backgroundImage: imageProvider,
                                            );
                                          },
                                          placeholder: (_, __) {
                                            return const CircleAvatar(
                                              child: Icon(Icons.music_note),
                                            );
                                          },
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.star_border),
                                        ),
                                        onTap: () => AppPages.push(context, AppPages.audio.path, audio),
                                      );
                                    },
                                  );
                          }
                          return centeredLoadingIndicator;
                        },
                      ),
                      FutureBuilder(
                        future: artist.getShorts(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final shorts = snapshot.requireData;
                            return shorts.isEmpty
                                ? Center(
                                    child: Text(
                                      'Nghệ sĩ này hiện chưa có video nào',
                                      style: context.textTheme.titleMedium,
                                    ),
                                  )
                                : GridView.builder(
                                    padding: const EdgeInsets.all(1),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 1,
                                      crossAxisSpacing: 1,
                                    ),
                                    itemCount: shorts.length,
                                    itemBuilder: (context, index) {
                                      return ShortGridTile(
                                        index: index,
                                        shorts: shorts,
                                      );
                                    },
                                  );
                          }
                          return centeredLoadingIndicator;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
