import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';
import 'package:src/exports/widgets.dart';
import 'package:television/pages/horivertical/horivertical_page.dart';
import 'package:television/pages/horivertical/horivertical_widget.dart';
import 'package:television/pages/horizontal/horizontal_widget.dart';

class HorizontalSubtitleText extends StatelessWidget {
  const HorizontalSubtitleText({super.key});

  @override
  Widget build(BuildContext context) {
    final subtitleLanguage = context.horizontalState.subtitleLanguage;
    return Builder(
      builder: (_) {
        if (subtitleLanguage == null) {
          return placeholder;
        } else {
          final playingSong = context.horiverticalState.playingSong;
          return FutureBuilder(
            future: Future.wait([
              playingSong.getSubtitles(subtitleLanguage),
              Future.value(<Subtitle>[]),
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
                            '(Phụ đề hiện không khả dụng)',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: subtitleTextStyle,
                          ),
                        ),
                      )
                    : StreamBuilder(
                        stream: player.positionStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final position = snapshot.requireData;
                            final primarySubtitle = primarySubtitles.singleWhere(
                              orElse: () => Subtitle.empty,
                              (subtitle) => position > subtitle.start && position < subtitle.end,
                            );
                            final secondarySubtitle = secondarySubtitles.singleWhere(
                              orElse: () => Subtitle.empty,
                              (subtitle) => position > subtitle.start && position < subtitle.end,
                            );
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.mediaHeight / 16,
                                vertical: context.mediaHeight / 32,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    primarySubtitle.text,
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
          );
        }
      },
    );
  }
}
