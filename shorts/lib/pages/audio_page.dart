import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/widgets.dart';

import '/widgets/short_grid_tile.dart';

class AudioPage extends StatelessWidget {
  const AudioPage(this.audio, {super.key});

  final Audio audio;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                backgroundColor: context.secondaryColor,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(
                    context.mediaHeight / 5,
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 8,
                          bottom: 16,
                        ),
                        child: SizedBox.square(
                          dimension: context.mediaHeight / 6,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: audio.getImageUrl(
                              YoutubeThumbnail.hqdefault,
                            ),
                            placeholder: (_, __) => MusicType.short.image,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 16,
                            bottom: 16,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                audio.getName(MusicLanguage.vi),
                                overflow: TextOverflow.ellipsis,
                                style: context.textTheme.titleLarge,
                              ),
                              FutureBuilder(
                                future: audio.getArtists(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final artists = snapshot.requireData;
                                    return Text(
                                      artists.getName(MusicLanguage.vi),
                                      overflow: TextOverflow.ellipsis,
                                      style: context.textTheme.bodyMedium,
                                    );
                                  }
                                  return emptyPlaceholder;
                                },
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.star_border),
                                    label: const Text('Yêu thích'),
                                    style: buttonStyle,
                                  ),
                                  const SizedBox(width: 4),
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      await Share.share(
                                        audio.getShareUrl(),
                                        subject: audio.runtimeType.toString(),
                                      );
                                    },
                                    icon: const Icon(Icons.share),
                                    label: const Text('Chia sẻ'),
                                    style: buttonStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: FutureBuilder(
            future: audio.getShorts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final shorts = snapshot.requireData;
                return shorts.isEmpty
                    ? Center(
                        child: Text(
                          'Chưa có video nào sử dụng bài hát này',
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
        ),
      ),
    );
  }
}
