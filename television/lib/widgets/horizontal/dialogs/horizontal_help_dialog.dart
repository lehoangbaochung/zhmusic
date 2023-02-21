part of '/pages/horizontal/horizontal_dialog.dart';

class HorizontalHelpDialog extends StatelessWidget {
  const HorizontalHelpDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalDialog(
      leading: HorizontalElevatedButton(
        icon: Icons.help,
        label: 'Hướng dẫn',
        onPressed: () {},
      ),
      trailing: HorizontalElevatedButton(
        icon: Icons.arrow_back,
        label: 'Quay lại',
        onPressed: () => Navigator.pop(context),
      ),
      child: Text(
        'Hiện chưa có hướng dẫn nào',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: context.labelTextStyle,
      ),
    );
  }
}
