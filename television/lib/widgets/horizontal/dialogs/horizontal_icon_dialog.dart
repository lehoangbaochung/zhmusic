part of '/pages/horizontal/horizontal_widget.dart';

class HorizontalIconDialog extends StatelessWidget {
  const HorizontalIconDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalBottomSheet.normal(
      leading: HorizontalElevatedButton(
        icon: Icons.theater_comedy,
        label: 'Nhãn dán',
        onPressed: () {},
      ),
      trailing: HorizontalElevatedButton(
        icon: Icons.arrow_back,
        label: 'Quay lại',
        onPressed: () => Navigator.pop(context),
      ),
      child: Text(
        'Tính năng đang được phát triển trong thời gian tới',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: context.textTheme.headlineMedium,
      ),
    );
  }
}
