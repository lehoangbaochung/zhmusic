part of '/pages/horizontal/horizontal_dialog.dart';

class HorizontalPlayerDialog extends StatelessWidget {
  const HorizontalPlayerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final player = context.playerCubit.player;
    return HorizontalDialog.normal(
      leading: HorizontalElevatedButton(
        icon: Icons.control_camera,
        label: 'Điều khiển',
        onPressed: () {},
      ),
      trailing: HorizontalElevatedButton(
        icon: Icons.close,
        label: 'Đóng',
        onPressed: () => Navigator.pop(context),
      ),
      child: Row(
        children: [
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.volume_up,
              label: 'Âm lượng',
              onPressed: () {
                Navigator.pop(context);
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
            child: HorizontalOutlinedButton.large(
              icon: Icons.pause,
              label: 'Tạm dừng',
              onPressed: () async {
                if (player.source != null) {
                  Navigator.pop(context);
                  if (player.state != PlayerState.playing) {
                    await player.play(player.source!);
                  } else {
                    await player.pause();
                  }
                }
              },
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.skip_next,
              label: 'Bài sau',
              onPressed: () {},
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.repeat,
              label: 'Lặp lại',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
