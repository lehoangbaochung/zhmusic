part of '/pages/horizontal/horizontal_dialog.dart';

class HorizontalAboutDialog extends StatelessWidget {
  const HorizontalAboutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return HorizontalDialog.normal(
      leading: HorizontalElevatedButton(
        icon: Icons.info,
        label: 'Giới thiệu',
        onPressed: () {},
      ),
      trailing: HorizontalElevatedButton(
        icon: Icons.arrow_back,
        label: 'Quay lại',
        onPressed: () => Navigator.pop(context),
      ),
      child: Text(
        'Do Zither Harp Music tự động tạo',
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: context.labelTextStyle,
      ),
    );
  }
}
