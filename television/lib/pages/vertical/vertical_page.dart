import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:television/app/app_storage.dart';
import 'package:television/pages/horivertical/horivertical_widget.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

class VerticalPage extends StatelessWidget {
  const VerticalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.horiverticalState.theme;
    final playlist = context.horiverticalState.playlist;
    final playingSong = context.horiverticalState.playingSong;
    final informations = appStorage.instance.informations.toList()..shuffle();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        onPressed: () {},
        label: RichText(
          text: TextSpan(
            text: 'Soạn tin: ',
            style: TextStyle(
              color: theme.infoTextColor,
            ),
            children: const [
              TextSpan(
                text: 'ZHM tên_bài_hát (tên_ca_sĩ)',
                style: TextStyle(
                  color: Colors.yellow,
                ),
              ),
              TextSpan(text: ' gửi '),
              TextSpan(
                text: 'ZHTV',
                style: TextStyle(
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
        ),
        icon: const Icon(Icons.how_to_vote),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Container(
          height: context.mediaHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(theme.backgroundUrl),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: playingSong.getImageUrl(
                      YoutubeThumbnail.maxresdefault,
                    ),
                    fit: BoxFit.fitWidth,
                    placeholder: (_, __) => placeholder,
                  ),
                  Positioned.fill(
                    top: context.mediaHeight / 64,
                    right: context.mediaWidth / 32,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              SizedBox.square(
                                dimension: context.mediaWidth / 6,
                                child: MusicType.music.image,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ngoại tuyến',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      background: Paint()
                                        ..strokeWidth = 1
                                        ..style = PaintingStyle.fill
                                        ..color = Colors.black.withOpacity(.6),
                                      foreground: Paint()
                                        ..strokeWidth = 1
                                        ..style = PaintingStyle.fill
                                        ..color = Colors.white,
                                    ),
                                  ),
                                  //SizedBox(width: context.mediaWidth / 256),
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Text(
                            'TV',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: context.mediaHeight / 16,
                            horizontal: context.mediaWidth / 16,
                          ),
                        ),
                        onPressed: () {},
                        child: FutureBuilder(
                          future: Future.sync(() async {
                            final artists = await playingSong.getArtists();
                            final name = playingSong.getName(MusicLanguage.vi);
                            final artistsName = artists.getName(MusicLanguage.vi, separator: ' & ');
                            return artists.isNotEmpty ? 'Đang phát: $name\nThể hiện: $artistsName' : 'Đang phát: $name';
                          }),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.requireData,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  background: Paint()
                                    ..strokeWidth = 1
                                    ..style = PaintingStyle.fill
                                    ..color = Colors.black.withOpacity(.6),
                                  foreground: Paint()
                                    ..strokeWidth = 1
                                    ..style = PaintingStyle.fill
                                    ..color = Colors.white,
                                ),
                              );
                            }
                            return placeholder;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: context.marqueeTextHeight,
                child: Marquee(
                  text: informations.first,
                  velocity: context.mediaWidth / 8,
                  blankSpace: context.mediaWidth,
                  style: TextStyle(
                    color: theme.playlistTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                  pauseAfterRound: const Duration(seconds: 1),
                ),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.filter_1,
                    color: Colors.red,
                  ),
                ),
                trailing: Stack(
                  children: [
                    CircularProgressIndicator(
                      value: .1,
                      color: theme.songVoteColor,
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${10}',
                          style: TextStyle(
                            color: theme.songVoteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                title: Text(
                  playlist.keys.elementAt(0).getName(MusicLanguage.vi),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: theme.songTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: FutureBuilder(
                  future: playlist.keys.elementAt(0).getArtists(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final artists = snapshot.requireData;
                      return Text(
                        artists.getName(MusicLanguage.vi),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: theme.songTextColor),
                      );
                    }
                    return placeholder;
                  },
                ),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.filter_2,
                    color: Colors.orange,
                  ),
                ),
                trailing: Stack(
                  children: [
                    CircularProgressIndicator(
                      value: .1,
                      color: theme.songVoteColor,
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${10}',
                          style: TextStyle(
                            color: theme.songVoteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                title: Text(
                  playlist.keys.elementAt(1).getName(MusicLanguage.vi),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: theme.songTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: FutureBuilder(
                  future: playlist.keys.elementAt(1).getArtists(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final artists = snapshot.requireData;
                      return Text(
                        artists.getName(MusicLanguage.vi),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: theme.songTextColor),
                      );
                    }
                    return placeholder;
                  },
                ),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.filter_3,
                    color: Colors.yellow,
                  ),
                ),
                trailing: Stack(
                  children: [
                    CircularProgressIndicator(
                      value: .1,
                      color: theme.songVoteColor,
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${10}',
                          style: TextStyle(
                            color: theme.songVoteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                title: Text(
                  playlist.keys.elementAt(2).getName(MusicLanguage.vi),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: theme.songTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: FutureBuilder(
                  future: playlist.keys.elementAt(2).getArtists(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final artists = snapshot.requireData;
                      return Text(
                        artists.getName(MusicLanguage.vi),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: theme.songTextColor),
                      );
                    }
                    return placeholder;
                  },
                ),
              ),
              FutureBuilder(
                future: Future.wait(
                  playlist.keys.map((song) async {
                    final artists = await song.getArtists();
                    final name = song.getName(MusicLanguage.vi);
                    final artistsName = artists.getName(MusicLanguage.vi, separator: ' & ');
                    return artists.isNotEmpty ? '$name - $artistsName' : name;
                  }),
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: context.marqueeTextHeight,
                      child: Marquee(
                        text: snapshot.requireData.join('; '),
                        velocity: context.mediaWidth / 8,
                        blankSpace: context.mediaWidth,
                        style: TextStyle(
                          color: theme.playlistTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                        pauseAfterRound: const Duration(seconds: 1),
                      ),
                    );
                  }
                  return placeholder;
                },
              ),
              const SizedBox(
                height: kToolbarHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
