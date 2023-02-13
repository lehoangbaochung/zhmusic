import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/extensions.dart';
import 'package:src/exports/widgets.dart';
import 'package:video_player/video_player.dart';

import '/widgets/horizontal/dialogs/horizontal_menu_dialog.dart';
import 'horizontal_widget.dart';

part 'horizontal_cubit.dart';
part 'horizontal_state.dart';

class HorizontalPage extends StatelessWidget {
  const HorizontalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final playlist = context.mainState.playlist;
    final playingSong = context.mainState.playingSong;
    final controller = context.mainState.videoPlayerController;
    return BlocBuilder<HorizontalCubit, HorizontalState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              // song screen
              Padding(
                padding: EdgeInsets.only(bottom: context.songBarHeight),
                child: Center(
                  child: FutureBuilder(
                    future: controller.play(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: VideoPlayer(controller),
                        );
                      }
                      return AspectRatio(
                        aspectRatio: controller.value.aspectRatio,
                        child: VideoPlayer(controller),
                      );
                    },
                  ),
                ),
              ),
              // channel logo
              Positioned(
                top: 50,
                right: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        SizedBox.square(
                          dimension: context.songBarHeight,
                          child: MusicType.television.image,
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Trực tiếp',
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'TV',
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // playing song
                  TextButton(
                    onPressed: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder: (_) => HorizontalSongDialog(playingSong, playlist[playingSong]!),
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
                          return Padding(
                            padding: const EdgeInsets.all(50),
                            child: Text(
                              snapshot.requireData,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                        return placeholder;
                      },
                    ),
                  ),
                  // info-line
                  Row(
                    children: [
                      Expanded(
                        child: HorizontalMarqueeText(
                          text: 'Kênh truyền hình âm nhạc tương tác trực tiếp dành cho giới trẻ ZHTV phát sóng đều đặn vào tối các ngày thứ bảy và chủ nhật hàng tuần. Kính mong các quý khán giả chú ý đón xem!',
                          onPressed: () {},
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // syntax line
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return HorizontalBottomSheet.normal(
                                leading: HorizontalElevatedButton(
                                  icon: Icons.arrow_back,
                                  label: 'Quay lại',
                                  onPressed: () => Navigator.pop(context),
                                ),
                                trailing: HorizontalElevatedButton(
                                  icon: Icons.how_to_vote,
                                  label: 'Bình chọn',
                                  onPressed: () => Navigator.pop(context),
                                ),
                                child: placeholder,
                              );
                            },
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.only(right: 8),
                          fixedSize: const Size.fromHeight(60),
                        ),
                        child: const AutoSizeText.rich(
                          TextSpan(
                            text: 'Soạn tin: ',
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text: 'ZHM tên_bài_hát (tên_ca_sĩ)',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.yellow,
                                ),
                              ),
                              TextSpan(text: ' gửi '),
                              TextSpan(
                                text: 'ZHTV',
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.yellow,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                            padding: EdgeInsets.zero,
                            icon: MusicType.audio.image,
                            onPressed: () async {
                              await showModalBottomSheet(
                                context: context,
                                builder: (_) => BlocProvider(
                                  child: const HorizontalDialog(),
                                  create: (_) => HorizontalDialogCubit(),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              // songs
                              Expanded(
                                child: Row(
                                  children: playlist.keys.take(3).map(
                                    (song) {
                                      final height = context.songBarHeight * 2 / 3;
                                      final index = playlist.keys.toList().indexOf(song);
                                      return Flexible(
                                        child: Container(
                                          height: height,
                                          padding: const EdgeInsets.all(8),
                                          child: TextButton(
                                            onPressed: () async {
                                              await showModalBottomSheet(
                                                context: context,
                                                builder: (_) => HorizontalSongDialog(song as Audio, playlist[song]!),
                                              );
                                            },
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                // song vote
                                                LinearProgressIndicator(
                                                  value: (playlist.values.elementAt(index) + 1) / playlist.values.length,
                                                  minHeight: height / 6,
                                                  color: Colors.red,
                                                  backgroundColor: Colors.transparent,
                                                ),
                                                // song name
                                                AutoSizeText(
                                                  song.getName(MusicLanguage.vi),
                                                  overflow: TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 28,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                // artist name
                                                FutureBuilder(
                                                  future: song.getArtists(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      final artists = snapshot.requireData;
                                                      return AutoSizeText(
                                                        artists.getName(MusicLanguage.vi),
                                                        overflow: TextOverflow.ellipsis,
                                                        textAlign: TextAlign.end,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 28,
                                                          fontWeight: FontWeight.bold,
                                                        ),
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
                                    return HorizontalMarqueeText(
                                      text: snapshot.requireData.join('; '),
                                      onPressed: () async {
                                        await showModalBottomSheet(
                                          context: context,
                                          builder: (_) {
                                            return HorizontalBottomSheet.normal(
                                              leading: HorizontalElevatedButton(
                                                icon: Icons.playlist_play,
                                                label: 'Playlist',
                                                onPressed: () {},
                                              ),
                                              trailing: HorizontalElevatedButton(
                                                icon: Icons.double_arrow,
                                                label: 'Xem thêm',
                                                onPressed: () => Navigator.pop(context),
                                              ),
                                              child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: playlist.length,
                                                itemBuilder: (context, index) {
                                                  final song = playlist.keys.elementAt(index);
                                                  return IconButton(
                                                    onPressed: () async {
                                                      await showModalBottomSheet(
                                                        context: context,
                                                        builder: (_) => HorizontalSongDialog(song as Audio, playlist[song]!),
                                                      );
                                                    },
                                                    padding: EdgeInsets.zero,
                                                    iconSize: context.songBarHeight,
                                                    tooltip: song.getName(MusicLanguage.vi),
                                                    icon: SizedBox.square(
                                                      dimension: context.songBarHeight,
                                                      child: Image.network(
                                                        fit: BoxFit.cover,
                                                        song.getImageUrl(
                                                          YoutubeThumbnail.hqdefault,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
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
