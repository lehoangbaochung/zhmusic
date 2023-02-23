import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/widgets.dart';

import '/pages/horivertical/horivertical_widget.dart';
import 'horizontal_dialog.dart';
import 'horizontal_widget.dart';

part 'horizontal_cubit.dart';
part 'horizontal_state.dart';

class HorizontalPage extends StatelessWidget {
  const HorizontalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HorizontalCubit, HorizontalState>(
      builder: (context, state) {
        final playlist = context.playerState.playlist;
        final playingSong = context.playerState.playingSong;
        return Scaffold(
          backgroundColor: Colors.black,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              // song screen
              Padding(
                padding: EdgeInsets.only(bottom: context.songBarHeight),
                child: Center(
                  child: Image.network(
                    playingSong.getImageUrl(
                      YoutubeThumbnail.maxresdefault,
                    ),
                  ),
                ),
              ),
              // channel logo
              Positioned(
                top: context.mediaHeight / 20,
                right: context.mediaWidth / 20,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        SizedBox.square(
                          dimension: context.songBarHeight * 0.8,
                          child: MusicType.music.image,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ngoại tuyến',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: context.fontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: context.mediaWidth / 512),
                            Container(
                              width: context.mediaWidth / 128,
                              height: context.mediaWidth / 128,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    //SizedBox(width: context.mediaWidth / 256),
                    Text(
                      'TV',
                      style: context.headlineTextStyle,
                    ),
                  ],
                ),
              ),
              // subtitle
              FutureBuilder(
                future: Future.wait([
                  playingSong.getSubtitles(MusicLanguage.zh),
                  playingSong.getSubtitles(MusicLanguage.zhHans),
                ]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final primarySubtitles = snapshot.requireData.first;
                    final secondarySubtitles = snapshot.requireData.last;
                    final subtitleTextStyle = TextStyle(
                      fontSize: context.fontSize,
                      background: Paint()
                        ..strokeWidth = 1
                        ..style = PaintingStyle.fill
                        ..color = Colors.black.withOpacity(.6),
                      foreground: Paint()
                        ..strokeWidth = 1
                        ..style = PaintingStyle.fill
                        ..color = Colors.white,
                    );
                    return primarySubtitles.isEmpty && secondarySubtitles.isEmpty
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.mediaHeight / 16,
                                vertical: context.mediaHeight / 64,
                              ),
                              child: Text(
                                '(Không có phụ đề khả dụng)',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: subtitleTextStyle,
                              ),
                            ),
                          )
                        : StreamBuilder(
                            stream: context.playerCubit.player.onPositionChanged,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final subtitle = primarySubtitles.singleWhere(
                                  orElse: () => Subtitle.empty,
                                  (subtitle) {
                                    final duration = snapshot.requireData;
                                    return duration >= subtitle.start && duration <= subtitle.end;
                                  },
                                );
                                final secondarySubtitle = secondarySubtitles.singleWhere(
                                  orElse: () => Subtitle.empty,
                                  (subtitle) {
                                    final duration = snapshot.requireData;
                                    return duration >= subtitle.start && duration <= subtitle.end;
                                  },
                                );
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: context.mediaHeight / 16,
                                    vertical: context.mediaHeight / 64,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        subtitle.text,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: subtitleTextStyle,
                                      ),
                                      Text(
                                        secondarySubtitle.text,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: subtitleTextStyle,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return placeholder;
                            },
                          );
                  }
                  return placeholder;
                },
              ),
              // player
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // playing song
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(
                        context.mediaHeight / 16,
                      ),
                    ),
                    onPressed: () {
                      context.showHorizontalDialog(
                        HorizontalSongDialog(playingSong),
                      );
                    },
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
                              fontSize: context.fontSize,
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
                  // info-line
                  SizedBox(
                    height: context.marqueeTextHeight,
                    child: Row(
                      children: [
                        Expanded(
                          child: HorizontalMarqueeText(
                            text: 'Kênh truyền hình âm nhạc tương tác trực tiếp dành cho giới trẻ ZHTV phát sóng đều đặn vào tối các ngày thứ bảy và chủ nhật hàng tuần. Kính mong các quý khán giả chú ý đón xem!',
                            onPressed: () {},
                          ),
                        ),
                        // syntax-line
                        TextButton(
                          style: TextButton.styleFrom(
                            fixedSize: Size.fromHeight(context.mediaHeight / 32),
                            padding: EdgeInsets.only(right: context.mediaHeight / 128),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actionsAlignment: MainAxisAlignment.center,
                                  title: const Text('Bình chọn'),
                                  content: const TextField(
                                    decoration: InputDecoration(
                                      prefixIcon: Text('ZHM'),
                                      hintText: 'Nhập tên bài hát hoặc ca sĩ...',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'Hủy',
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'Bình chọn',
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Soạn tin: ',
                              style: context.marqueeTextStyle,
                              children: [
                                TextSpan(
                                  text: 'ZHM tên_bài_hát (tên_ca_sĩ)',
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: context.fontSize,
                                  ),
                                ),
                                const TextSpan(text: ' gửi '),
                                TextSpan(
                                  text: 'ZHTV',
                                  style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: context.fontSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // song bar
                  Container(
                    height: context.songBarHeight,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                          'https://static.vecteezy.com/system/resources/previews/002/058/477/original/floral-nature-spring-background-free-vector.jpg',
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox.square(
                          dimension: context.songBarHeight,
                          child: IconButton(
                            autofocus: true,
                            padding: EdgeInsets.zero,
                            icon: MusicType.audio.image,
                            onPressed: () async {
                              context.showHorizontalDialog(
                                const HorizontalMenuDialog(),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              // songs
                              Row(
                                children: playlist.keys.take(3).map(
                                  (song) {
                                    final height = context.songBarHeight * 2 / 3;
                                    final index = playlist.keys.toList().indexOf(song);
                                    return Flexible(
                                      child: Container(
                                        height: height,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: context.mediaWidth / 128,
                                          vertical: context.mediaHeight / 128,
                                        ),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.zero,
                                            fixedSize: Size.fromHeight(height),
                                          ),
                                          onPressed: () {
                                            context.showHorizontalDialog(
                                              HorizontalSongDialog(song),
                                            );
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              // song vote
                                              LinearProgressIndicator(
                                                value: (playlist.values.elementAt(index) + 1) / playlist.values.length,
                                                minHeight: height / 6,
                                                color: Colors.red,
                                                backgroundColor: Colors.transparent,
                                              ),
                                              // song name
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: context.mediaHeight / 256,
                                                ),
                                                child: Text(
                                                  song.getName(MusicLanguage.vi),
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: context.songTextStyle,
                                                ),
                                              ),
                                              // artist name
                                              FutureBuilder(
                                                future: song.getArtists(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    final artists = snapshot.requireData;
                                                    return Text(
                                                      artists.getName(MusicLanguage.vi),
                                                      overflow: TextOverflow.ellipsis,
                                                      textAlign: TextAlign.right,
                                                      style: context.songTextStyle,
                                                    );
                                                  }
                                                  return placeholder;
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                              // playlist
                              FutureBuilder(
                                future: Future.wait(
                                  playlist.keys.map((song) async {
                                    final artists = await song.getArtists();
                                    final name = song.getName(MusicLanguage.vi);
                                    final artistsName = artists.getName(
                                      MusicLanguage.vi,
                                      separator: ' & ',
                                    );
                                    return artists.isNotEmpty ? '$name - $artistsName' : name;
                                  }),
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Expanded(
                                      child: HorizontalMarqueeText(
                                        text: snapshot.requireData.join('; '),
                                        onPressed: () async {
                                          context.showHorizontalDialog(
                                            const HorizontalPlaylistDialog(),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                  return placeholder;
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
