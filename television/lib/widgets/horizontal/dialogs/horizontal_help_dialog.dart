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
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: context.mediaHeight / 32,
          horizontal: context.mediaWidth / 128,
        ),
        child: Text(
          appStorage.instance.help,
          textAlign: TextAlign.justify,
          style: context.textTheme.bodyMedium,
        ),
      ),
    );
  }
}
