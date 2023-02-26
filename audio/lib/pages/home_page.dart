import 'package:audio/app/app_pages.dart';
import 'package:audio/pages/search_page.dart';
import 'package:audio/widgets/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/repositories.dart';
import 'package:src/exports/widgets.dart';
import 'package:src/extensions/music.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trang chủ',
          style: context.textTheme.headlineSmall,
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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.history),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: context.getHeight(16),
          horizontal: context.getWidth(8),
        ),
        child: Column(
          children: [
            FutureBuilder(
              future: musicStorage.getArtists(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final artists = snapshot.requireData.shuffled;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ca sĩ phổ biến',
                            style: context.textTheme.titleMedium,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Xem thêm'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: context.mediaHeight / 5,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          separatorBuilder: (_, __) {
                            return SizedBox(
                              width: context.getWidth(8),
                            );
                          },
                          itemBuilder: (context, index) {
                            final artist = artists.elementAt(index);
                            return InkWell(
                              onTap: () => AppPages.push(context, AppPages.artist.path, artist),
                              child: SizedBox(
                                width: context.getWidth(60),
                                child: Column(
                                  children: [
                                    Container(
                                      height: context.getWidth(60),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            artist.getImageUrl(),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: context.getHeight(8),
                                    ),
                                    Text(
                                      artist.getName(MusicLanguage.vi),
                                      overflow: TextOverflow.ellipsis,
                                      style: context.textTheme.labelMedium,
                                    ),
                                  ],
                                ),
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
            ),
            SizedBox(
              height: context.getHeight(16),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bài hát hôm nay',
                      style: context.textTheme.titleMedium,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Xem thêm'),
                    ),
                  ],
                ),
                SizedBox(
                  height: context.mediaHeight / 5,
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: context.getWidth(8),
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.network(
                                    'https://y.qq.com/music/photo_new/T002R300x300M000003Z6l901SQFFg.jpg?max_age=2592000',
                                  ).image,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: context.getHeight(4),
                          ),
                          Text(
                            'Quay về (bản nữ)',
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.network(
                                    'https://y.qq.com/music/photo_new/T002R300x300M000003Z6l901SQFFg.jpg?max_age=2592000',
                                  ).image,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: context.getHeight(4),
                          ),
                          Text(
                            'Quay về (bản nữ)',
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: Image.network(
                                    'https://y.qq.com/music/photo_new/T002R300x300M000003Z6l901SQFFg.jpg?max_age=2592000',
                                  ).image,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: context.getHeight(4),
                          ),
                          Text(
                            'Quay về (bản nữ)',
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: context.getHeight(16),
                ),
                // recommend songs
                FutureBuilder(
                  future: musicStorage.getAudios(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final audios = snapshot.requireData.shuffled;
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Mọi người đang nghe',
                                style: context.textTheme.titleMedium,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Xem thêm'),
                              ),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(bottom: context.getHeight(128)),
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              final audio = audios.elementAt(index);
                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
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
                                  width: context.getWidth(40),
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
                                trailing: const Icon(Icons.play_circle),
                              );
                            },
                          ),
                        ],
                      );
                    }
                    return centeredLoadingIndicator;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
