import 'package:flutter/material.dart';
import 'package:src/exports/entities.dart';

import '/app/app_storage.dart';
import '/pages/horivertical/horivertical_widget.dart';
import '/pages/horizontal/horizontal_dialog.dart';
import '/pages/horizontal/horizontal_widget.dart';
import 'dialogs/horizontal_information_dialog.dart';

class HorizontalInformationText extends StatelessWidget {
  const HorizontalInformationText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.horiverticalState.theme;
    final informations = appStorage.instance.informations.toList()..shuffle();
    return SizedBox(
      height: context.marqueeTextHeight,
      child: Row(
        children: [
          // info-line
          Expanded(
            child: HorizontalMarqueeText(
              text: informations.first,
              onPressed: () async {
                await context.showHorizontalDialog(
                  const HorizontalInformationDialog(),
                );
              },
            ),
          ),
          // syntax-line
          TextButton(
            style: TextButton.styleFrom(
              fixedSize: Size.fromHeight(context.mediaHeight / 32),
              padding: EdgeInsets.only(right: context.mediaWidth / 128),
            ),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (_) {
                  final voteTextController = TextEditingController();
                  return AlertDialog(
                    actionsAlignment: MainAxisAlignment.center,
                    title: const Text('Bình chọn'),
                    content: TextField(
                      controller: voteTextController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (value) async {
                        Navigator.pop(context);
                        await context.showHorizontalDialog(
                          HorizontalVoteDialog(
                            songs: context.horiverticalState.library.where((song) {
                              final songName = song.getName(MusicLanguage.vi).toLowerCase();
                              return songName.contains(voteTextController.text.toLowerCase());
                            }),
                          ),
                        );
                      },
                    ),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 0),
                        onPressed: () async {
                          Navigator.pop(context);
                          await context.showHorizontalDialog(
                            HorizontalVoteDialog(
                              songs: context.horiverticalState.library.where((song) {
                                final songName = song.getName(MusicLanguage.vi).toLowerCase();
                                return songName.contains(voteTextController.text.toLowerCase());
                              }),
                            ),
                          );
                        },
                        child: const Text('Gửi'),
                      ),
                    ],
                  );
                },
              );
            },
            child: RichText(
              text: TextSpan(
                text: 'Soạn tin: ',
                style: TextStyle(
                  color: theme.infoTextColor,
                  fontSize: context.fontSize,
                ),
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
    );
  }
}
