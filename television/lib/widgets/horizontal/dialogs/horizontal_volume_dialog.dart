part of '/pages/horizontal/horizontal_dialog.dart';

class HorizontalVolumeDialog extends StatelessWidget {
  const HorizontalVolumeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalDialog.normal(
      leading: HorizontalElevatedButton(
        icon: Icons.volume_up,
        label: 'Âm lượng',
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
              icon: Icons.volume_off,
              label: 'Tắt',
              onPressed: () async {
                Navigator.pop(context);
                await context.playerCubit.player.setVolume(0);
              },
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.volume_mute,
              label: 'Nhỏ',
              onPressed: () async {
                Navigator.pop(context);
                await context.playerCubit.player.setVolume(1 / 3);
              },
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.volume_down,
              label: 'Vừa',
              onPressed: () async {
                Navigator.pop(context);
                await context.playerCubit.player.setVolume(2 / 3);
              },
            ),
          ),
          Expanded(
            child: HorizontalOutlinedButton.large(
              icon: Icons.volume_up,
              label: 'Lớn',
              onPressed: () async {
                Navigator.pop(context);
                await context.playerCubit.player.setVolume(1);
              },
            ),
          ),
        ],
      ),
    );
  }
}
