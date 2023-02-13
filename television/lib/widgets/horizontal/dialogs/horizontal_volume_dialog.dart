part of '/pages/horizontal/horizontal_widget.dart';

class HorizontalVolumeDialog extends StatelessWidget {
  const HorizontalVolumeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final volume = context.mainState.videoPlayerController.value.volume;
    return HorizontalBottomSheet.normal(
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
      child: Slider(
        value: volume,
        label: '${volume * 100}',
        onChanged: (value) => context.mainState.videoPlayerController.setVolume(value),
      ),
    );
  }
}
