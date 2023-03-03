import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:src/exports/entities.dart';

import '/app/app_storage.dart';
import '/widgets/horizontal/horizontal_channel_logo.dart';
import '/widgets/horizontal/horizontal_information_text.dart';
import '/widgets/horizontal/horizontal_playing_song.dart';
import '/widgets/horizontal/horizontal_song_bar.dart';
import '/widgets/horizontal/horizontal_song_screen.dart';
import '/widgets/horizontal/horizontal_subtitle_text.dart';
import 'horizontal_widget.dart';

part 'horizontal_cubit.dart';
part 'horizontal_state.dart';

class HorizontalPage extends StatelessWidget {
  const HorizontalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HorizontalCubit, HorizontalState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              const HorizontalSongScreen(),
              Positioned(
                top: context.mediaHeight / 16,
                right: context.mediaWidth / 16,
                child: const HorizontalChannelLogo(),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.mediaHeight / 32,
                    horizontal: context.mediaHeight / 16,
                  ),
                  child: const HorizontalSubtitleText(),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  HorizontalPlayingSong(),
                  HorizontalInformationText(),
                  HorizontalSongBar(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
