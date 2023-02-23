part of '/pages/horizontal/horizontal_dialog.dart';

class HorizontalPlayerDialog extends StatelessWidget {
  const HorizontalPlayerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final player = context.playerCubit.player;
    return HorizontalDialog(
      leading: HorizontalElevatedButton(
        icon: Icons.play_circle,
        label: 'Trình phát',
        onPressed: () {},
      ),
      trailing: HorizontalElevatedButton(
        icon: Icons.arrow_back,
        label: 'Quay lại',
        onPressed: () => Navigator.pop(context),
      ),
      child: Row(
        children: [
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.volume_up,
              label: 'Âm lượng',
              onPressed: () {
                context.showHorizontalDialog(
                  const HorizontalVolumeDialog(),
                );
              },
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.subtitles,
              label: 'Phụ đề',
              onPressed: () async {
                context.showHorizontalDialog(
                  const HorizontalSubtitleDialog(),
                );
              },
            ),
          ),
          Expanded(
            child: StatefulBuilder(
              builder: (context, setState) {
                final playing = player.state == PlayerState.playing;
                return HorizontalOutlinedButton.large(
                  icon: playing ? Icons.pause : Icons.play_arrow,
                  label: playing ? 'Tạm dừng' : 'Phát',
                  onPressed: () async {
                    if (player.source == null) {
                      await player.play(
                        UrlSource(
                          await context.playerState.playingSong.getStreamUrl(
                            audioOnly: context.playerState.audioOnly,
                          ),
                        ),
                      );
                    } else {
                      if (playing) {
                        await player.pause();
                      } else {
                        await player.play(player.source!);
                      }
                    }
                    setState(() {});
                  },
                );
              },
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.skip_next,
              label: 'Bài sau',
              onPressed: () => context.playerCubit.next(),
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.source,
              label: 'Nguồn phát',
              onPressed: () {
                context.showHorizontalDialog(
                  HorizontalDialog(
                    leading: HorizontalElevatedButton(
                      icon: Icons.source,
                      label: 'Nguồn phát',
                      onPressed: () => Navigator.pop(context),
                    ),
                    trailing: HorizontalElevatedButton(
                      icon: Icons.arrow_back,
                      label: 'Quay lại',
                      onPressed: () => Navigator.pop(context),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: HorizontalOutlinedButton.large(
                            label: 'Ngoại tuyến',
                            icon: Icons.reset_tv,
                            onPressed: () {
                              context.showHorizontalDialog(
                                HorizontalDialog(
                                  leading: HorizontalElevatedButton(
                                    icon: Icons.reset_tv,
                                    label: 'Ngoại tuyến',
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  trailing: HorizontalElevatedButton(
                                    icon: Icons.arrow_back,
                                    label: 'Quay lại',
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: HorizontalOutlinedButton.large(
                                          icon: Icons.audiotrack,
                                          label: 'Audio',
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: HorizontalOutlinedButton.large(
                                          icon: Icons.video_library,
                                          label: 'Video',
                                          onPressed: null,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: HorizontalOutlinedButton.large(
                            label: 'Trực tuyến',
                            icon: Icons.connected_tv,
                            onPressed: null,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
