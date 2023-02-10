import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/widgets.dart';

import '/pages/main/main_page.dart';
import 'horizontal_widget.dart';

part 'horizontal_cubit.dart';
part 'horizontal_state.dart';

class HorizontalPage extends StatelessWidget {
  const HorizontalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mainState = context.watch<MainCubit>().state;
    return BlocBuilder<HorizontalCubit, HorizontalState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              // song screen
              Container(
                color: Colors.black,
                margin: EdgeInsets.only(bottom: context.mediaHeight),
                child: Center(
                  child: Image.network(
                    mainState.playingSong.getImageUrl(
                      YoutubeThumbnail.maxresdefault,
                    ),
                  ),
                ),
              ),
              // channel logo
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox.square(
                        dimension: 150,
                        child: MusicType.short.image,
                      ),
                      const Text(
                        'SD',
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
                    'Trực tiếp',
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Playing song
                  HorizontalPlayingSong(mainState.playingSong),
                  // Info-line
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: Marquee(
                              text: 'Kênh truyền hình âm nhạc tương tác trực tiếp dành cho giới trẻ ZHTV phát sóng đều đặn vào tối các ngày thứ bảy và chủ nhật hàng tuần. Kính mong các quý khán giả chú ý đón xem!',
                              style: marqueeTextStyle,
                              velocity: 150,
                              blankSpace: context.mediaWidth,
                              pauseAfterRound: const Duration(seconds: 1),
                            ),
                          ),
                        ),
                        // The line of syntax
                        RichText(
                          text: const TextSpan(
                            text: 'Soạn tin: ',
                            style: marqueeTextStyle,
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
                          'https://wallpaper.dog/large/20513846.jpg',
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        // Library logo
                        InkWell(
                          child: MusicType.short.image,
                          onTap: () {},
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  children: mainState.playlist.take(3).map(
                                    (song) {
                                      return Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 16,
                                          ),
                                          child: HorizontalSongTile(song),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                ),
                              ),
                              const HorizontalPlaylistMarquee(),
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
