import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/repositories.dart';
import 'package:src/exports/widgets.dart';

import '/app/app_pages.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text('Lyric'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.lyrics),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
          ),
          IconButton(
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: SearchPage(),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    '.../assets/images/lyric.png',
                  ),
                ),
              ),
              child: SizedBox.shrink(),
            ),
            ListTile(
              selected: true,
              minLeadingWidth: 0,
              leading: const Icon(Icons.home),
              title: const Text('Trang chủ'),
              onTap: () => AppPages.pop(context),
            ),
            ListTile(
              minLeadingWidth: 0,
              leading: const Icon(Icons.settings),
              title: const Text('Cài đặt'),
              onTap: () => AppPages.push(context, AppPages.settings.path),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: musicStorage.getAudios(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final audios = snapshot.requireData.toList()..shuffle();
            return ListView.builder(
              itemCount: audios.length,
              itemBuilder: (context, index) {
                final audio = audios.elementAt(index);
                return ListTile(
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
                      return const SizedBox.shrink();
                    },
                  ),
                  leading: const SizedBox(
                    height: double.infinity,
                    child: Icon(Icons.audiotrack),
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.star_border),
                  ),
                  onTap: () => AppPages.push(context, AppPages.lyric.path, audio),
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
