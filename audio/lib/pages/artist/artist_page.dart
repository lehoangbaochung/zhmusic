import 'package:audio/widgets/app_widget.dart';
import 'package:audio/widgets/player_bar.dart';
import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/widgets.dart';

import '../search_page.dart';

part 'audio_page.dart';

class ArtistPage extends StatelessWidget {
  const ArtistPage(this.artist, {super.key});

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Trang chủ', 'Bài hát', 'Album', 'Video', 'Giới thiệu'];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        bottomSheet: const PlayerBar(),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                elevation: 3,
                expandedHeight: context.getHeight(320),
                flexibleSpace: FlexibleSpaceBar(
                  background: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.primaryColor.withOpacity(.6),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.network(
                          artist.getImageUrl(TencentMusicImage.large),
                        ).image,
                      ),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: SearchPage(),
                      );
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: ListTile(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                    ),
                    tileColor: context.primaryColor.withOpacity(.8),
                    title: Text(
                      artist.getName(MusicLanguage.vi),
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      artist.getName(MusicLanguage.zhHans),
                      style: const TextStyle(color: Colors.black),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.black,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Column(
            children: [
              TabBar(
                isScrollable: true,
                tabs: tabs.map((e) => Tab(text: e)).toList(),
              ),
              Expanded(
                child: TabBarView(
                  children: tabs.map((String name) {
                    return ArtistProvider(
                      artist: artist,
                      child: const AudioFragment(),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
