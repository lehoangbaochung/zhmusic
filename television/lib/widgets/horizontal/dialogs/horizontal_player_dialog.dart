part of '/pages/horizontal/horizontal_dialog.dart';

class HorizontalPlayerDialog extends StatelessWidget {
  const HorizontalPlayerDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
              icon: Icons.skip_previous,
              label: 'Bài trước',
              onPressed: null,
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: player.playingStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final playing = snapshot.requireData;
                  return HorizontalOutlinedButton.large(
                    icon: playing ? Icons.pause : Icons.play_arrow,
                    label: playing ? 'Tạm dừng' : 'Phát',
                    onPressed: () async {
                      if (playing) {
                        await player.pause();
                      } else {
                        await player.play();
                      }
                    },
                  );
                }
                return centeredLoadingIndicator;
              },
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.skip_next,
              label: 'Bài sau',
              onPressed: () => context.horiverticalCubit.next(),
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
        ],
      ),
    );
  }
}
